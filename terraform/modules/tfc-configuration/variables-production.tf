module "variable-set-production" {
  source = "./variable-set"

  name         = "common-production"
  organization = var.organization
  tfvars = {
    publishing_platform_environment = "production"
    vpc_cidr                        = "10.13.0.0/16"
  }
}