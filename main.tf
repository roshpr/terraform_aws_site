
provider "aws" {
  access_key  = "${var.aws["access_key"]}"
  secret_key  = "${var.aws["secret_key"]}"
  region = "${var.aws["region"]}"
}

module "site_central" {
  source  = "site"
  name = "site"
  vpcvar = "${var.vpc}"
  enable_dns_hostnames = true
  enable_dns_support = true
  public_acl_inbound_tcp = ""
}
