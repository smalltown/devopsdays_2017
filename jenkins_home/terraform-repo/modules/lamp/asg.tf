resource "aws_autoscaling_group" "lamp_asg" {
  lifecycle { create_before_destroy = true }

  # spread the app instances across the availability zones
  availability_zones = ["${split(",", var.asg_availability_zones)}"]


  # interpolate the LC into the ASG name so it always forces an update
  name = "${var.name}-${var.lc_image_id}"
  max_size = "${var.asg_max_size}"
  min_size = "${var.asg_min_size}"
  wait_for_elb_capacity = 2
  desired_capacity = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  launch_configuration = "${aws_launch_configuration.lamp_lc.id}"
  load_balancers = ["${aws_elb.lamp.id}"]
  vpc_zone_identifier = ["${split(",", var.subnet_ids)}"]

  tag {
    key = "Name"
    value = "${var.name}-${var.lc_image_id}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "lamp_lc" {
  lifecycle { create_before_destroy = true }

  name = "${var.name}-${var.lc_image_id}"
  image_id = "${var.lc_image_id}"
  instance_type = "${var.lc_instance_type}"
  key_name = "${var.lc_key_name}"
  associate_public_ip_address = true

  root_block_device {
    "volume_type" = "gp2"
    "volume_size" = 100
  }

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.lamp.id}"]

}

resource "aws_autoscaling_policy" "lamp_scale_out" {

    name = "${var.name}-scale-out"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.lamp_asg.name}"
}

resource "aws_autoscaling_policy" "lamp_scale_in" {

    name = "${var.name}-scale-in"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.lamp_asg.name}"
}
