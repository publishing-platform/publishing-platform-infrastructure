// There will only ever be a production ecr workspace.  All container images are stored in production AWS account.
module "ecr-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization        = var.organization
  workspace_name      = "ecr-production"
  workspace_desc      = "This module manages Elastic Container Registry repositories, to store OCI images of Publishing Platform apps"
  workspace_tags      = ["production", "ecr", "eks", "aws"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/ecr/"
  trigger_patterns    = ["/terraform/modules/ecr/**/*"]
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
    "ecr-production",
    "github-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
    module.variable-set-ecr-production,
    module.variable-set-github-production
  ]
}