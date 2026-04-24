module "cluster-infrastructure-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.15.0"

  organization        = var.organization
  workspace_name      = "cluster-infrastructure-production"
  workspace_desc      = "This module manages the EKS cluster, and other resources it depends on (e.g. IAM roles and policies)"
  workspace_tags      = ["production", "cluster-infrastructure", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/cluster-infrastructure/"
  trigger_patterns    = ["/terraform/modules/cluster-infrastructure/**/*"]
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
    module.variable-set-production
  ]
}