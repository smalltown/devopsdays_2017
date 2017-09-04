
module "vpc" {
  source = "../../../../modules/network/vpc"
  name = "${var.common["name_prefix"]}-${var.common["phase"]}"
  phase = "${var.common["phase"]}"
  base_cidr_block = "${var.vpc["base_cidr_block"]}"
}
