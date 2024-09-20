module "variable-set-production" {
  source = "./variable-set"

  name         = "common-production"
  organization = var.organization
  tfvars = {
    publishing_platform_environment = "production"
  }
}