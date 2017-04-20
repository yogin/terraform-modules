
resource "aws_instance" "bastion" {
  count = "${length(var.availability_zones)}"
  ami = "${coalesce(var.ami, data.aws_ami.ubuntu.id)}"
  instance_type = "${var.type}"

  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  availability_zone = "${var.availability_zones[count.index]}"
  subnet_id = "${var.public_subnet_ids[count.index]}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }

  tags {
    Name = "${var.vpc_name}-bastion-${count.index + 1}"
    VPC = "${var.vpc_name}"
    Environment = "${var.environment}"
  }
}
