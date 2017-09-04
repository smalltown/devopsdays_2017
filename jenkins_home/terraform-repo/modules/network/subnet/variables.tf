variable "vpc_id" {}
variable "name" {}
variable "availability_zone" {}
variable "cidr_block" {}
variable "route_table_id" {}

data "aws_vpc" "target" {
  id = "${var.vpc_id}"
}
