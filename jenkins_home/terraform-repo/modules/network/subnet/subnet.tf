resource "aws_subnet" "main" {
  availability_zone = "${var.availability_zone}"
  cidr_block = "${var.cidr_block}"
  vpc_id     = "${var.vpc_id}"

  tags {
      Name = "${var.name}"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${var.route_table_id}"
}
