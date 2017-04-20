
data "aws_availability_zone" "az" {
  count = "${length(var.azs)}"
  name  = "${var.azs[count.index]}"
}

