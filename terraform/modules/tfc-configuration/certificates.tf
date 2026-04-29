module "certificates-production" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization      = var.organization
  workspace_name    = "certificates-production"
  workspace_desc    = "This module manages certificates for the production environment."
  workspace_tags    = ["production", "certificates", "aws"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/certificates/"
  trigger_patterns = [
    "/terraform/modules/certificates/**/*",
    "/terraform/variables/production/common.tfvars",
    "/terraform/variables/variables-common.tf",
    "/terraform/variables/production/certificates.tfvars"
  ]
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  tfvars_files = [
    "production/common.tfvars",
    "production/certificates.tfvars"
  ]

  variable_set_names = [
    "aws-credentials-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production
  ]
}