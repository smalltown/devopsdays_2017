variable "name" {}
variable "vpc_id" {}
variable "subnet_ids" {}

variable "asg_availability_zones" {}
variable "asg_max_size" {}
variable "asg_min_size" {}

variable "lc_image_id" {}
variable "lc_instance_type" {}
variable "lc_key_name" {}

output "elb_dns_name" { value = "${ aws_elb.lamp.dns_name }" }
