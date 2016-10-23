/* Creates a nat-gw per availability zone and add the default route for private subnets to that zone's nat-gw */

resource "aws_eip" "nat_eip" {
  vpc   = true
  count = "${length(split(",", var.vpcvar["availability_zones"]))}"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  count         = "${length(split(",", var.vpcvar["availability_zones"]))}"
}

resource "aws_route" "route_nat_gateway" {
  route_table_id         = "${element(aws_route_table.route_table_private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
  count                  = "${length(split(",", var.vpcvar["private_subnets"]))}"

  depends_on             = ["aws_route_table.route_table_private"]
}

/*
resource "aws_route_table_association" "nat" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  count          = "${length(split(",", var.private_subnets))}"
}*/

