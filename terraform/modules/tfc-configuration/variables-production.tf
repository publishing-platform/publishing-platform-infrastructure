module "variable-set-production" {
  source = "./variable-set"

  name         = "common-production"
  organization = var.organization
  tfvars = {
    publishing_platform_environment = "production"

    vpc_cidr = "10.13.0.0/16"

    eks_control_plane_subnets = {
      a = { az = "eu-west-1a", cidr = "10.13.19.0/28" }
      b = { az = "eu-west-1b", cidr = "10.13.19.16/28" }
      c = { az = "eu-west-1c", cidr = "10.13.19.32/28" }
    }

    eks_public_subnets = {
      a = { az = "eu-west-1a", cidr = "10.13.20.0/24" }
      b = { az = "eu-west-1b", cidr = "10.13.21.0/24" }
      c = { az = "eu-west-1c", cidr = "10.13.22.0/24" }
    }

    eks_private_subnets = {
      a = { az = "eu-west-1a", cidr = "10.13.24.0/22" }
      b = { az = "eu-west-1b", cidr = "10.13.28.0/22" }
      c = { az = "eu-west-1c", cidr = "10.13.32.0/22" }
    }
  }
}