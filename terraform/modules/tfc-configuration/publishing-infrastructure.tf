module "publishing-infrastructure-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.15.0"

  organization        = var.organization
  workspace_name      = "publishing-infrastructure-production"
  workspace_desc      = "This module manages AWS resources which are specific to Publishing Platform Publishing."
  workspace_tags      = ["production", "publishing-infrastructure", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/publishing-infrastructure/"
  trigger_patterns    = ["/terraform/modules/publishing-infrastructure/**/*"]
  global_remote_state = true

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  variable_set_names = [
    "aws-credentials-production",
    # "common",
    "common-production",
    "publishing-infrastructure-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
    module.variable-set-publishing-infrastructure-production
  ]
}
