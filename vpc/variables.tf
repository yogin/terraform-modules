
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

variable "cidr" {
  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
}

variable "name" {
  description = "VPC base name"
  default = "demo"
}

variable "environment" {
  description = "VPC Environment Tag"
  default = "development"
}

variable "azs" {
  description = "Availability Zones to use"
  type    = "list"
  default = ["us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "cidr_bits" {
  description = "Bits to add to the cidr when building subnets"
  default     = 8
}

variable "az_number" {
  description = "AZ Zone letter mapping"
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
  }
}

variable "public_net_offset" {
  description = "CIDR block offset for public subnets"
  default = 0
}

variable "private_net_offset" {
  description = "CIDR block offset for private subnets"
  default = 100
}

