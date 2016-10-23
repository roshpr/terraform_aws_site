resource "aws_network_acl" "public_acl" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    subnet_ids = ["${aws_subnet.public_subnet.*.id}"]

/*    ingress {
        protocol = "tcp"
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 80
        to_port = 80
    }

    ingress {
        protocol = "tcp"
        rule_no = 501
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    ingress {
        protocol = "tcp"
        rule_no = 502
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 22
        to_port = 22
    }

    ingress {
        protocol = "tcp"
        rule_no = 503
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 1024
        to_port = 65535
    }

    egress {
        protocol = "tcp"
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 80
        to_port = 80
    }

    egress {
        protocol = "tcp"
        rule_no = 501
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    egress {
        protocol = "tcp"
        rule_no = 502
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 1024
        to_port = 65535
    }

    egress {
        protocol = "tcp"
        rule_no = 503
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 22
        to_port = 22
    }
*/
    ingress {
        protocol = -1
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    egress {
        protocol = -1
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "public_acl"
    }
}

/*
resource "aws_network_acl_rule" "public_ingress_ssh" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${600 + count.index }"
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "${element(split(",", var.home_networks), count.index)}"
    from_port = 22
    to_port = 22
    count = "${length(compact(split(",", var.home_networks)))}"
}

resource "aws_network_acl_rule" "public_ingress_rdp" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${700 + count.index }"
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "${element(split(",", var.home_networks), count.index)}"
    from_port = 3389
    to_port = 3389
    count = "${length(compact(split(",", var.home_networks)))}"
}
*/

/*
resource "aws_network_acl_rule" "public_ingress_tcp" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${800 + count.index }"
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "${element(split("-", element(split(",", var.public_acl_inbound_tcp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.public_acl_inbound_tcp), count.index)), 1)}"
    count = "${length(compact(split(",", var.public_acl_inbound_tcp)))}"
}

resource "aws_network_acl_rule" "public_ingress_udp" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${900 + count.index }"
    egress = false
    protocol = "udp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "${element(split("-", element(split(",", var.public_acl_inbound_udp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.public_acl_inbound_udp), count.index)), 1)}"
    count = "${length(compact(split(",", var.public_acl_inbound_udp)))}"
}


resource "aws_network_acl_rule" "public_egress_tcp" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${600 + count.index }"
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "${element(split("-", element(split(",", var.public_acl_outbound_tcp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.public_acl_outbound_tcp), count.index)), 1)}"
    count = "${length(compact(split(",", var.public_acl_outbound_tcp)))}"
}

resource "aws_network_acl_rule" "public_egress_udp" {
    network_acl_id = "${aws_network_acl.public_acl.id}"
    rule_number = "${700 + count.index }"
    egress = true
    protocol = "udp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = "${element(split("-", element(split(",", var.public_acl_outbound_udp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.public_acl_outbound_udp), count.index)), 1)}"
    count = "${length(compact(split(",", var.public_acl_outbound_udp)))}"
}
*/

/* private subnet acl */

resource "aws_network_acl" "private_acl" {
    vpc_id = "${aws_vpc.vpc_main.id}"
    subnet_ids = ["${aws_subnet.private_subnet.*.id}"]

/*    ingress {
        protocol = "tcp"
        rule_no = 500
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 80
        to_port = 80
    }

    ingress {
        protocol = "tcp"
        rule_no = 501
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 443
        to_port = 443
    }

    ingress {
        protocol = "tcp"
        rule_no = 502
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 22
        to_port = 22
    }

    # high ports for local subnet and return traffic from nat-gw

    ingress {
        protocol = "tcp"
        rule_no = 503
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 1024
        to_port = 65535
    }
    egress {
        protocol = "tcp"
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 80
        to_port = 80
    }

    egress {
        protocol = "tcp"
        rule_no = 501
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    egress {
        protocol = "tcp"
        rule_no = 502
        action = "allow"
        cidr_block =  "${var.vpc_cidr}"
        from_port = 1024
        to_port = 65535
    } */
    ingress {
        protocol = -1
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    egress {
        protocol = -1
        rule_no = 500
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    tags {
        Name = "private_acl"
    }
}

/*
resource "aws_network_acl_rule" "private_ingress_tcp" {
    network_acl_id = "${aws_network_acl.private_acl.id}"
    rule_number = "${600 + count.index }"
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = "${element(split("-", element(split(",", var.private_acl_inbound_tcp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.private_acl_inbound_tcp), count.index)), 1)}"
    count = "${length(compact(split(",", var.private_acl_inbound_tcp)))}"
}

resource "aws_network_acl_rule" "private_ingress_udp" {
    network_acl_id = "${aws_network_acl.private_acl.id}"
    rule_number = "${700 + count.index }"
    egress = false
    protocol = "udp"
    rule_action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = "${element(split("-", element(split(",", var.private_acl_inbound_udp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.private_acl_inbound_udp), count.index)), 1)}"
    count = "${length(compact(split(",", var.private_acl_inbound_udp)))}"
}

resource "aws_network_acl_rule" "private_egress_tcp" {
    network_acl_id = "${aws_network_acl.private_acl.id}"
    rule_number = "${800 + count.index }"
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = "${element(split("-", element(split(",", var.private_acl_outbound_tcp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.private_acl_outbound_tcp), count.index)), 1)}"
    count = "${length(compact(split(",", var.private_acl_outbound_tcp)))}"
}

resource "aws_network_acl_rule" "private_egress_udp" {
    network_acl_id = "${aws_network_acl.private_acl.id}"
    rule_number = "${900 + count.index }"
    egress = true
    protocol = "udp"
    rule_action = "allow"
    cidr_block = "${var.vpc_cidr}"
    from_port = "${element(split("-", element(split(",", var.private_acl_outbound_udp), count.index)), 0)}"
    to_port = "${element(split("-", element(split(",", var.private_acl_outbound_udp), count.index)), 1)}"
    count = "${length(compact(split(",", var.private_acl_outbound_udp)))}"
}
*/