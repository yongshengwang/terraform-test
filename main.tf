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
  access_key = "AKIA3EYUCAV74AWAH3CB"
  secret_key = "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"
}
resource "aws_instance" "web_server" {
  ami = "ami-02d1e544b84bf7502"
  instance_type = "t2.micro"
  tags = {name="test"}
}