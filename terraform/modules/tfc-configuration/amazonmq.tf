// This will be deleted and resources added to publishing-infrastructure workspace
module "amazonmq-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization        = var.organization
  workspace_name      = "amazonmq-production"
  workspace_desc      = "Temporary workspace for amazonmq testing"
  workspace_tags      = ["production", "amazonmq", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/amazonmq/"
  trigger_patterns    = ["/terraform/modules/amazonmq/**/*"]
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
    "common-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
  ]
}