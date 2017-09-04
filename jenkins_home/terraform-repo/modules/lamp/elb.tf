resource "aws_elb" "lamp" {
  name = "lamp"

  cross_zone_load_balancing = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 10
  }

  idle_timeout = 60

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  security_groups = [
    "${aws_security_group.lamp.id}",
  ]

  subnets = [ "${ split(",", var.subnet_ids) }" ]

  tags {
    Name = "${var.name}"
  }
}
