# This module exists purely to decouple objects from other modules (e.g. publishing-infrastructure) and will be removed in future.
# Allows the destruction of other modules while preserving objects that may be being used externally.
module "shared-production" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization        = var.organization
  workspace_name      = "shared-production"
  workspace_desc      = "This module manages objects that may be required by other modules."
  workspace_tags      = ["production", "shared", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/shared/"
  trigger_patterns = [
    "/terraform/modules/shared/**/*",
    "/terraform/variables/production/common.tfvars",
    "/terraform/variables/variables-common.tf"
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
    "production/common.tfvars"
  ]

  variable_set_names = [
    "aws-credentials-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production
  ]
}