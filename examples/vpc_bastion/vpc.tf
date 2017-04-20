
module "vpc" {
  source = "../../vpc"

  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
  name        = "${var.name}"
  environment = "${var.environment}"
}

