
resource "aws_elb" "bastion" {
  name                      = "bastion-elb"
  security_groups           = ["${aws_security_group.bastion_elb.id}"]
  subnets                   = ["${var.public_subnet_ids}"]
  cross_zone_load_balancing = true
  connection_draining       = true

  listener {
    lb_port           = 22
    lb_protocol       = "tcp"
    instance_port     = 22
    instance_protocol = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 10
  }


  tags {
    Name        = "${var.vpc_name}-bastion-elb"
    VPC         = "${var.vpc_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_launch_configuration" "bastion" {
  name_prefix                 = "bastion-lc-"
  image_id                    = "${var.ami}"
  instance_type               = "${var.type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = false

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion" {
  name                  = "bastion-asg-${aws_launch_configuration.bastion.name}"
  availability_zones    = "${var.availability_zones}"
  launch_configuration  = "${aws_launch_configuration.bastion.id}"
  vpc_zone_identifier   = ["${var.private_subnet_ids}"]
  load_balancers        = ["${aws_elb.bastion.id}"]
  termination_policies  = ["OldestInstance"]

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

  lifecycle {
    create_before_destroy = true
  }
}

