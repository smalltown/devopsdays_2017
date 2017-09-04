data "aws_availability_zones" "all" {
  state = "available"
}

data "aws_availability_zone" "primary" {
  name = "${data.aws_availability_zones.all.names[0]}"
}

data "aws_availability_zone" "secondary" {
  name = "${data.aws_availability_zones.all.names[1]}"
}

data "aws_availability_zone" "tertiary" {
  name = "${data.aws_availability_zones.all.names[2]}"
}

data "aws_vpc" "target" {
  id = "${aws_vpc.main.id}"
}

module "primary_subnet" {
  name = "${var.name}-a"
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[0]}"
  cidr_block = "${cidrsubnet(data.aws_vpc.target.cidr_block, 2, lookup(var.az_numbers, data.aws_availability_zone.primary.name_suffix) - 1)}"
  route_table_id = "${aws_route_table.main.id}"
}

module "secondary_subnet" {
  name = "${var.name}-b"
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[1]}"
  cidr_block = "${cidrsubnet(data.aws_vpc.target.cidr_block, 2, lookup(var.az_numbers, data.aws_availability_zone.secondary.name_suffix) - 1)}"
  route_table_id = "${aws_route_table.main.id}"
}

module "tertiary_subnet" {
  name = "${var.name}-c"
  source            = "../subnet"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.all.names[2]}"
  cidr_block = "${cidrsubnet(data.aws_vpc.target.cidr_block, 2, lookup(var.az_numbers, data.aws_availability_zone.tertiary.name_suffix) - 1)}"
  route_table_id = "${aws_route_table.main.id}"
}
