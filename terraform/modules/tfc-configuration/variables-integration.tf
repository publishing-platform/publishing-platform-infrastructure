module "variable-set-integration" {
  source = "./variable-set"

  name         = "common-integration"
  organization = var.organization
  tfvars = {
    publishing_platform_environment = "integration"
  }
}

module "variable-set-gcp-credentials-integration" {
  source = "./variable-set"

  name         = "gcp-credentials-integration"
  organization = var.organization
  tfvars = {
  }
}

module "variable-set-search-integration" {
  source = "./variable-set"

  name         = "search-integration"
  organization = var.organization
  tfvars = {
  }
}