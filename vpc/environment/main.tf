module "example_vpc" {
   source     = "../modules/vpc"
   env        = var.env
   subnet     = "10.0.0.0/24"
   cidr_block = "10.0.0.0/16"
   providers = {
       aws = aws.us_west_1
   }
}

variable "key_name" {}

resource "tls_private_key" "web" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = "${tls_private_key.web.public_key_openssh}"
}

resource "aws_instance" "demo" {
  ami		         = "ami-09d9c5cdcfb8fc655"
  instance_type          = "t2.micro"
  subnet_id 		 = module.example_vpc.subnet_id
  vpc_security_group_ids = module.example_vpc.webserver-rules
  key_name      	 = aws_key_pair.generated_key.key_name

  tags = {
    Name = var.instance_name
  }
}
