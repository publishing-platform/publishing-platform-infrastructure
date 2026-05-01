module "variable-set-github-production" {
  source = "./variable-set"

  name         = "github-production"
  organization = var.organization
  tfvars = {
  }
}

module "variable-set-aws-credentials-production" {
  source = "./variable-set"

  name         = "aws-credentials-production"
  organization = var.organization
  tfvars = {
  }
}

module "variable-set-gcp-credentials-production" {
  source = "./variable-set"

  name         = "gcp-credentials-production"
  organization = var.organization
  tfvars = {
  }
}