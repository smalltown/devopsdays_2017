module "lamp" {

    source = "../../../../modules/lamp"

    name = "${var.common["name_prefix"]}_${var.common["phase"]}"
    vpc_id = "${module.vpc.id}"
    subnet_ids = "${module.vpc.primary_subnet_id},${module.vpc.secondary_subnet_id},${module.vpc.tertiary_subnet_id}"

    asg_availability_zones = "${var.lamp_asg["availability_zones"]}"
    asg_max_size = "${var.lamp_asg["max_size"]}"
    asg_min_size = "${var.lamp_asg["min_size"]}"

    lc_image_id = "${var.lamp_lc["image_id"]}"
    lc_instance_type = "${var.lamp_lc["instance_type"]}"
    lc_key_name = "${var.lamp_lc["key_name"]}"
}
