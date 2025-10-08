module "search-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.10.0"

  organization        = var.organization
  workspace_name      = "search-production"
  workspace_desc      = "This module manages the provision of GCP Vertex AI Search resources."
  workspace_tags      = ["production", "search", "gcp"]
  terraform_version   = var.terraform_version
  execution_mode      = "remote"
  working_directory   = "/terraform/modules/search/"
  trigger_patterns    = ["/terraform/modules/search/**/*"]
  global_remote_state = true

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  variable_set_names = [
    "gcp-credentials-production",
    "aws-credentials-production",
    # "common",
    "common-production",
    "search-production"
  ]

  depends_on = [
    module.variable-set-gcp-credentials-production,
    module.variable-set-aws-credentials-production,
    module.variable-set-production,
    module.variable-set-search-production
  ]
}
