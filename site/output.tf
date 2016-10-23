output "vpc" {
    value = "${aws_vpc.vpc_main.id}"
}

output "igw" {
    value = "${aws_internet_gateway.ig_main.id}"
}

output "public_subnets" {
    value = "${join(",", aws_subnet.public_subnet.*.id)}"
}

output "private_subnets" {
    value = "${join(",", aws_subnet.private_subnet.*.id)}"
}

output "public_route_tables" {
    value = "${join(",", aws_route_table.route_table_public.*.id)}"
}

output "private_route_tables" {
    value = "${join(",", aws_route_table.route_table_private.*.id)}"
}

output "nat_gws" {
    value = "${aws_nat_gateway.nat_gateway.id}"
}

output "public_acl" {
    value = "${aws_network_acl.public_acl.id}"
}

output "private_acl" {
    value = "${aws_network_acl.private_acl.id}"
}

output "iam_bootstrap_role" {
    value = "${aws_iam_role.ec2_bootstrap_iam_role.name}"
}
output "site_name" {
    value = "${var.name}"
}



