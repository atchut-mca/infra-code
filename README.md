# infra-code

# Pre-requisites

- Create an AWS Account
- Create an IAM user from the console with Administrator access
- Download the access and secret keys which looks like an example below. These are just dummy keys below.
    - AWSERR232SF112S335A
    - asdasd123#$!as$fghh+wasd{aasdfgh@3345eet
- Download the latest version of terraform from the following location to your local
    https://www.terraform.io/downloads.html

# Cloning locally

Clone the repository locally using the following command

git clone https://github.com/atchut-mca/infra-code

# Terraform execution

Open a shell/command line from the local

Change the directory to the folder the GitHub repo cloned to

Initialize the terraform using the following command

- terraform init

Plan the terraform using the following command to see what are the resources that are getting created

- terraform plan -aws_access_key AWSERR232SF112S335A -aws_secret_key asdasd123#$!as$fghh+wasd{aasdfgh@3345eet

Create the infrastructure using the following command

- terraform apply -aws_access_key AWSERR232SF112S335A -aws_secret_key asdasd123#$!as$fghh+wasd{aasdfgh@3345eet

# Browsing the site

Once the infrastructure created check the website with the public IP that is stored locally in the file as "public-ip.txt" as stated in the ec2.tf file
