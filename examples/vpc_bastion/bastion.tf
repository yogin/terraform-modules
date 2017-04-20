
module "bastion" {
  source = "../../bastion"

  access_key                  = "${var.access_key}"
  secret_key                  = "${var.secret_key}"
  region                      = "${var.region}"
  vpc_name                    = "${var.name}"
  environment                 = "${var.environment}"

  vpc_id                      = "${module.vpc.vpc_id}"
  availability_zones          = "${module.vpc.availability_zones}"
  public_subnet_ids           = "${module.vpc.public_subnet_ids}"
  internal_security_group_id  = "${module.vpc.internal_security_group_id}"
  key_name                    = "${var.ssh_key_name}"
}

