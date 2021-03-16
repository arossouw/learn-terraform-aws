terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_instance" "demo" {
  #ami           = "ami-031b673f443c2172c"
  ami		= "ami-09d9c5cdcfb8fc655"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}