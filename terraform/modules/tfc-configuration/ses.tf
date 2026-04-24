module "ses-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.15.0"

  organization        = var.organization
  workspace_name      = "ses-production"
  workspace_desc      = "This module manages the AWS Simple Email Service (SES) used by applications to send emails."
  workspace_tags      = ["production", "ses", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/ses/"
  trigger_patterns    = ["/terraform/modules/ses/**/*"]
  global_remote_state = true
  allow_destroy_plan  = false

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
    "ses-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
    module.variable-set-ses-production
  ]
}
