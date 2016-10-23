variable "name" { }
variable "vpcvar" {
  type = "map"
  default = {
    vpc_cidr = ""
    public_subnets = ""
    private_subnets = ""
    availability_zones = ""
    nat_gateways_count = ""
    home_networks = ""
  }
}
variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default = false
}
variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default = false
}
variable "private_propagating_vgws" {
  description = "A comma separated list of VGWs the private route table should propagate."
  default = ""
}
variable "public_propagating_vgws" {
  description = "A comma separated list of VGWs the public route table should propagate."
  default = ""
}

variable "public_acl_inbound_tcp" {
  description = "A comma separated list of allowed ingress acl tcp port or port-range."
  default = ""
}

variable "public_acl_inbound_udp" {
  description = "A comma separated list of allowed ingress acl udp port or port-range."
  default = ""
}

variable "public_acl_outbound_tcp" {
  description = "A comma separated list of allowed outbound acl tcp port or port-range."
  default = ""
}

variable "public_acl_outbound_udp" {
  description = "A comma separated list of allowed outbound acl tcp port or port-range."
  default = ""
}

variable "private_acl_inbound_tcp" {
  description = "A comma separated list of allowed ingress acl tcp ports from within vpc."
  default = ""
}

variable "private_acl_inbound_udp" {
  description = "A comma separated list of allowed ingress acl udp ports from within vpc."
  default = ""
}

variable "private_acl_outbound_tcp" {
  description = "A comma separated list of allowed ingress acl tcp ports from within vpc."
  default = ""
}

variable "private_acl_outbound_udp" {
  description = "A comma separated list of allowed ingress acl udp ports from within vpc."
  default = ""
}

variable "nat_gateways_count" {
  description = "can be between 1 and number of public subnets"
  default     = "1"
}

variable "root_path" {}
