
resource "aws_subnet" "public" {
  count                   = "${length(var.azs)}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${cidrsubnet(var.cidr, var.cidr_bits, var.az_number[data.aws_availability_zone.az.*.name_suffix[count.index]] + var.public_net_offset)}"
  availability_zone       = "${var.azs[count.index]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-sn-public-${data.aws_availability_zone.az.*.name_suffix[count.index]}"
    VPC = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.name}-rt-public"
    VPC         = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "internet_route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.azs)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"

  lifecycle {
    create_before_destroy = true
  }
}

