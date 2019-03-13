/*
Configure the AWS Provider
aws_access_key - IAM Access key
aws_secret_key - IAM Secret key
aws_region - Default region to be spinned for resources
*/
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}
