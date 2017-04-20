
data "aws_ami" "ubuntu_xenial_hvm" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

output "ubuntu_xenial_hvm" {
  value = "${data.aws_ami.ubuntu_xenial_hvm.id}"
}

