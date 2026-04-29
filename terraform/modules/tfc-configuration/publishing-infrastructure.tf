module "publishing-infrastructure-production" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization      = var.organization
  workspace_name    = "publishing-infrastructure-production"
  workspace_desc    = "This module manages AWS resources which are specific to Publishing Platform Publishing."
  workspace_tags    = ["production", "publishing-infrastructure", "eks", "aws"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/publishing-infrastructure/"
  trigger_patterns = [
    "/terraform/modules/publishing-infrastructure/**/*",
    "/terraform/variables/production/common.tfvars",
    "/terraform/variables/variables-common.tf",
    "/terraform/variables/production/publishing-infrastructure.tfvars"
  ]
  global_remote_state = true

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  tfvars_files = [
    "production/common.tfvars",
    "production/publishing-infrastructure.tfvars"
  ]

  variable_set_names = [
    "aws-credentials-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production
  ]
}
