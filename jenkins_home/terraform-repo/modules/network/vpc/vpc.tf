resource "aws_vpc" "main" {
  cidr_block = "${var.base_cidr_block}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
      Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name}-igw"
    }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.name}-default"
  }
}
