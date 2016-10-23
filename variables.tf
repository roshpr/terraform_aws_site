variable "name" {
  description = "Name of the vpc/cluster, used for naming different resources"
  default = "site"
}

variable "vpc" {
  type = "map"
  default = {
    vpc_cidr = "10.0.0.0/16"
    public_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
    private_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"
    availability_zones = "us-east-1a,us-east-1b,us-east-1d"
    nat_gateways_count = "3"
    home = "116.196.170.0/27"
  }
}

variable "aws" {
  type = "map"
  default = {
    profile = "myprof"
    access_key = ""
    secret_key = ""
    key_name = "roshkey"
    region = "us-east-1"
  }
}
