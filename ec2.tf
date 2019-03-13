/*
AMI Filter to pick up the latest Ubuntu AMI from AWS
*/
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

/*
Deploy ssh key for instance access
*/
resource "aws_key_pair" "deployer" {
  key_name   = "web_server"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

/*
Build the EC2 instance with the AMI from AMI Filter and the deployed with the key for access
connection - deploys the key pair for access
remote-exec - executes the remote commands on the EC2 once it is ready
file - deploys a local index.html file into the server
local-exec - executes a local command from the build server
*/
resource "aws_instance" "web_server" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
  instance_type          = "${var.instance_type}"
  key_name               = "web_server"

  tags {
    Name = "web-server"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
      "sudo systemctl enable apache2",
      "sudo systemctl start apache2",
      "sudo chmod 777 /var/www/html/index.html",
    ]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/var/www/html/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 644 /var/www/html/index.html",
    ]
  }

  # Save the public IP for testing
  provisioner "local-exec" {
    command = "echo ${aws_instance.web_server.public_ip} > public-ip.txt"
  }
}
