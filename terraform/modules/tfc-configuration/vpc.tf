module "vpc-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.15.0"

  organization        = var.organization
  workspace_name      = "vpc-production"
  workspace_desc      = "This module manages foundational cloud resources that are required by most other modules (VPC, DNS zones)"
  workspace_tags      = ["production", "vpc", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/vpc/"
  trigger_patterns    = ["/terraform/modules/vpc/**/*"]
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
    "common-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production
  ]
}