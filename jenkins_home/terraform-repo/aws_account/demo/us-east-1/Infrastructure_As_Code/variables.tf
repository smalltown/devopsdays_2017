provider "aws" {}

terraform { backend "s3" {} }

variable "common" {
  type = "map"
  default = {
    name_prefix = "devopsdays"
    phase = "demo"
  }
}

variable "vpc" {
  type = "map"
  default = {
    base_cidr_block = "172.20.0.0/16"
  }
}

variable "lamp_asg" {
  type = "map"
  default = {
    availability_zones = ""
    max_size = "5"
    min_size = "2"
  }
}

variable "lamp_lc" {
  type = "map"
  default = {
    image_id = "ami-ffd2d1e9"
    instance_type = "t2.large"
    key_name = "lamp"
  }
}

output "lamp_dns_name" { value = "${ module.lamp.elb_dns_name }" }
output "image_id" { value = "${ var.lamp_lc["image_id"] }" }
