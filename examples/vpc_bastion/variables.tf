
variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
  default = "us-east-1"
}

variable "name" {
  description = "VPC base name"
  default = "demo"
}

variable "environment" {
  description = "VPC Environment Tag"
  default = "development"
}

variable "ssh_key_name" {
  description = "SSH Key Name"
  default = ""
}

