
variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
}

variable "vpc_id" {
  description = "VPC Id"
}

variable "vpc_name" {
  description = "VPC name"
}

variable "environment" {
  description = "Environment name"
}

variable "internal_security_group_id" {
  description = "Security group ID for internal EC2 instances"
}

variable "public_subnet_ids" {
  description = "List of public subnets"
  type = "list"
}

variable "private_subnet_ids" {
  description = "List of private subnets"
  type = "list"
}

variable "availability_zones" {
  description = "List of availability zones"
  type = "list"
}

variable "ami" { 
  description = "AMI"
  default = ""
}

variable "type" {
  description = "Instance Type"
  default = "t2.micro"
}

variable "volume_size" {
  description = "Disk size in GB"
  default = "8"
}

variable "key_name" {
  description = "SSH Key"
  default = ""
}

variable "whitelist" {
  description = "SSH Whitelist"
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}

variable "min_instances" {
  description = "Minimum number of instances"
  default = 1
}

variable "max_instances" {
  description = "Maximum number of instances"
  default = 2
}

variable "desired_instances" {
  description = "Desired number of instances"
  default = 1
}

