/*
Variables used for AWS Provider awsprovider.tf
*/
variable "aws_access_key" {
  description = "IAM Access key"
}

variable "aws_secret_key" {
  description = "IAM Secret key"
}

variable "aws_region" {
  description = "Region to spin up the resources"
  default     = "us-east-1"
}

/*
Variables used for EC2 ec2.tf
*/

variable "instance_type" {
  description = "Instance type to be spun up"
  default     = "t2.micro"
}
