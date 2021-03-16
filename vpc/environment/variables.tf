## variables.tf of module
variable "subnet" {
  default = "10.0.0.0/24"
}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "vpc_security_group_ids" {
  default = ["webserver-rule"]
}

variable "instance_name" {
  default = "test_ec2"
}

variable "env" {}