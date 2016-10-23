resource "aws_vpc" "vpc_main" {
  cidr_block = "${var.vpcvar["vpc_cidr"]}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"
  tags { Name = "${var.name}" }
}

resource "aws_internet_gateway" "ig_main" {
  vpc_id = "${aws_vpc.vpc_main.id}"
}

resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  propagating_vgws = ["${compact(split(",", var.public_propagating_vgws))}"]
  tags { Name = "${var.name}.route_table_public" }
}
resource "aws_route_table" "route_table_private" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  propagating_vgws = ["${compact(split(",", var.private_propagating_vgws))}"]
  count = "${length(compact(split(",", var.vpcvar["private_subnets"])))}"

  tags { Name = "${var.name}.route_table_private.${count.index}" }
}

resource "aws_route" "route_public_ig" {
    route_table_id = "${aws_route_table.route_table_public.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig_main.id}"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  count = "${length(compact(split(",", var.vpcvar["private_subnets"])))}"
  cidr_block = "${element(split(",", var.vpcvar["private_subnets"]), count.index)}"
  availability_zone = "${element(split(",", var.vpcvar["availability_zones"]), count.index)}"

  tags {
    Name = "${var.name}.private_subnet.${count.index}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  count = "${length(compact(split(",", var.vpcvar["public_subnets"])))}"
  cidr_block = "${element(split(",", var.vpcvar["public_subnets"]), count.index)}"
  availability_zone = "${element(split(",", var.vpcvar["availability_zones"]), count.index)}"
  tags {
    Name = "${var.name}.public_subnet.${count.index}"
  }

  map_public_ip_on_launch = false // instances launched in public subnet should not get public ip by default.
}

resource "aws_route_table_association" "private" {
  count = "${length(compact(split(",", var.vpcvar["private_subnets"])))}"
  subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.route_table_private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count = "${length(compact(split(",", var.vpcvar["public_subnets"])))}"
  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

