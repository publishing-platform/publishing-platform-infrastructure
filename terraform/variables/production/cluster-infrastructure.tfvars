cluster_version               = "1.33"
cluster_log_retention_in_days = 7

eks_control_plane_subnets = {
  a = { az = "eu-west-2a", cidr = "10.13.19.0/28" }
  b = { az = "eu-west-2b", cidr = "10.13.19.16/28" }
  c = { az = "eu-west-2c", cidr = "10.13.19.32/28" }
}

eks_public_subnets = {
  a = { az = "eu-west-2a", cidr = "10.13.20.0/24" }
  b = { az = "eu-west-2b", cidr = "10.13.21.0/24" }
  c = { az = "eu-west-2c", cidr = "10.13.22.0/24" }
}

eks_private_subnets = {
  a = { az = "eu-west-2a", cidr = "10.13.24.0/22" }
  b = { az = "eu-west-2b", cidr = "10.13.28.0/22" }
  c = { az = "eu-west-2c", cidr = "10.13.32.0/22" }
}

workers_instance_types = ["t3.medium"]
workers_size_desired   = 4

force_destroy = true # TODO: should be removed in production