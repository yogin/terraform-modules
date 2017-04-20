
resource "aws_security_group" "internal" {
  name        = "internal"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id      = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.name}-sg-internal"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "internal_ingress" {
  security_group_id = "${aws_security_group.internal.id}"
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  self              = true
}

resource "aws_security_group_rule" "internal_egress" {
  security_group_id = "${aws_security_group.internal.id}"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  self              = true
}

resource "aws_security_group" "nat" {
  name        = "nat"
  description = "Security group that allows all inbound and outbound traffic. Should only be applied to instances in a private subnet"
  vpc_id      = "${aws_vpc.default.id}"
  depends_on  = ["aws_nat_gateway.nat_gw"]

  tags {
    Name        = "${var.name}-sg-nat"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "nat_ingress" {
  security_group_id        = "${aws_security_group.nat.id}"
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "0"
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.internal.id}"
}

resource "aws_security_group_rule" "nat_egress" {
  security_group_id = "${aws_security_group.nat.id}"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

