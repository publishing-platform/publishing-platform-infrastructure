module "tfc-gcp-config-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization        = var.organization
  workspace_name      = "tfc-gcp-config-production"
  workspace_desc      = "Creates GCP projects and configures Terraform Cloud as an external OIDC provider."
  workspace_tags      = ["production", "tfc", "gcp", "configuration"]
  terraform_version   = var.terraform_version
  execution_mode      = "local"
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "tfc-configuration"
}