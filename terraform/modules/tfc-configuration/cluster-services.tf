module "cluster-services-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization      = var.organization
  workspace_name    = "cluster-services-production"
  workspace_desc    = "This module manages resources for services that run on top of the EKS cluster and are required by apps running on the cluster"
  workspace_tags    = ["production", "cluster-services", "eks", "aws"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/cluster-services/"
  trigger_patterns  = ["/terraform/modules/cluster-services/**/*"]

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