// There will only ever be a production github workspace.
module "github-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.12.0"

  organization        = var.organization
  workspace_name      = "github-production"
  workspace_desc      = "This module configures GitHub resources"
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/github/"
  trigger_patterns    = ["/terraform/modules/github/**/*"]
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  variable_set_names = [
    # "common",
    "common-production",
    "github-production"
  ]

  depends_on = [
    module.variable-set-production,
    module.variable-set-github-production
  ]
}