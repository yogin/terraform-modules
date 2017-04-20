
resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Security group that allows inbound SSH traffic to bastion servers"
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.vpc_name}-sg-bastion"
    VPC         = "${var.vpc_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = "${aws_security_group.bastion.id}"
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = "${var.whitelist}"
}

resource "aws_security_group_rule" "allow_internal" {
  security_group_id = "${aws_security_group.bastion.id}"
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  source_security_group_id = "${var.internal_security_group_id}"
}

resource "aws_security_group_rule" "allow_bastion" {
  security_group_id = "${var.internal_security_group_id}"
  type = "ingress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  source_security_group_id = "${aws_security_group.bastion.id}"
}

