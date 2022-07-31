terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"

}

module "instance" {
  source = "./modules/ec2"
  enable_ec2 = true
  enable_s3 = true
  bucket_name = "tiny-test-1986"
}