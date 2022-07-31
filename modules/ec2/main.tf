variable "instance_type" {
  description = "EC2 Type"
  type = string
  default = "t2.micro"
}

variable "instance_tags" {
  default = {
    name = "test"
  }
  type = map(string)
  description = "EC2 tags"
}

variable "bucket_name" {
  type = string
  description = "EC2 tags"
}

variable "enable_s3" {
  type = bool
  default = false
  description = "Enable S3"
}
variable "enable_ec2" {
  type = bool
  default = false
  description = "Enable EC2"
}

resource "aws_security_group" "web_server_sg_http" {
  name = "web_server_sg_http"
  ingress {
    from_port = 80
    protocol  = "TCP"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_server_sg_ssh" {
  name = "web_server_sg_ssh"
  ingress {
    from_port = 22
    protocol  = "TCP"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  count = var.enable_ec2? 1: 0
  ami = "ami-02d1e544b84bf7502"
  instance_type = var.instance_type
  tags = var.instance_tags
  vpc_security_group_ids = [aws_security_group.web_server_sg_ssh.id, aws_security_group.web_server_sg_http.id]
  user_data = <<-EOF
            #! /bin/bash
            yum update -y
            yum install httpd -y
            systemctl start httpd
            systemctl enable httpd
            cd /var/www/html
            echo "tiny" > index.html
              EOF
}

resource "aws_s3_bucket" "test_bucket" {
  count = var.enable_s3? 1: 0
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

