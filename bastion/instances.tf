
resource "aws_launch_configuration" "bastion" {
  name                        = "bastion-lc"
  image_id                    = "${var.ami}"
  instance_type               = "${var.type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }
}

resource "aws_autoscaling_group" "bastion" {
  name                  = "bastion-asg"
  availability_zones    = "${var.availability_zones}"
  launch_configuration  = "${aws_launch_configuration.bastion.id}"
  vpc_zone_identifier   = ["${var.public_subnet_ids}"]
  min_size              = "${var.min_instances}"
  max_size              = "${var.max_instances}"
  desired_capacity      = "${var.desired_instances}"

  tag {
    key                 = "VPC"
    value               = "${var.vpc_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-bastion"
    propagate_at_launch = true
  }
}

