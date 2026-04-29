private_subnets = {
  a = { az = "eu-west-2a", cidr = "10.13.60.0/22" }
  b = { az = "eu-west-2b", cidr = "10.13.64.0/22" }
  c = { az = "eu-west-2c", cidr = "10.13.68.0/22" }
}

force_destroy = true # TODO: should be removed in production