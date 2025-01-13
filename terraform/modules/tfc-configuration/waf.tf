module "waf-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization        = var.organization
  workspace_name      = "waf-production"
  workspace_desc      = "This module manages the web application firewall."
  workspace_tags      = ["production", "waf", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/waf/"
  trigger_patterns    = ["/terraform/modules/waf/**/*"]
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
    "waf-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
    module.variable-set-waf-production
  ]
}