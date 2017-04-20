
resource "aws_subnet" "private" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${cidrsubnet(var.cidr, var.cidr_bits, var.az_number[data.aws_availability_zone.az.*.name_suffix[count.index]] + var.private_net_offset)}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_nat_gateway.nat_gw"]

  tags {
    Name        = "${var.name}-sn-private-${data.aws_availability_zone.az.*.name_suffix[count.index]}"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "private" {
  count  = "${length(var.azs)}"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.name}-rt-private-${data.aws_availability_zone.az.*.name_suffix[count.index]}"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "nat_route" {
  count                  = "${length(var.azs)}"
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gw.*.id[count.index]}"
  depends_on             = ["aws_nat_gateway.nat_gw"]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_route_table_association" "private" {
  count          = "${length(var.azs)}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"

  lifecycle {
    create_before_destroy = true
  }
}

