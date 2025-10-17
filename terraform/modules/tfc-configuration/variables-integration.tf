module "variable-set-gcp-credentials-integration" {
  source = "./variable-set"

  name         = "gcp-credentials-integration"
  organization = var.organization
  tfvars = {
  }
}