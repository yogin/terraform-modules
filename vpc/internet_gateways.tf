
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.name}-ig"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "nat_eip" {
  count = "${length(var.azs)}"
  vpc   = true
}

resource "aws_nat_gateway" "nat_gw" {
  count         = "${length(var.azs)}"
  allocation_id = "${aws_eip.nat_eip.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"

  lifecycle {
    create_before_destroy = true
  }
}

