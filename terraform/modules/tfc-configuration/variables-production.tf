module "variable-set-production" {
  source = "./variable-set"

  name = "common-production"
  organisation = var.organisation
  tfvars = {
    publishing_platform_environment = "production"
  }
}