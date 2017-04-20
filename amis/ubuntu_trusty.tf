
data "aws_ami" "ubuntu_trusty_hvm" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

output "ubuntu_trusty_hvm" {
  value = "${data.aws_ami.ubuntu_trusty_hvm.id}"
}

