module "search-integration" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization      = var.organization
  workspace_name    = "search-integration"
  workspace_desc    = "This module manages the provision of GCP Vertex AI Search resources."
  workspace_tags    = ["integration", "search", "gcp"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/search/"
  trigger_patterns = [
    "/terraform/modules/search/**/*",
    "/terraform/variables/integration/common.tfvars",
    "/terraform/variables/variables-common.tf",
    "/terraform/variables/integration/search.tfvars"
  ]
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  tfvars_files = [
    "integration/common.tfvars",
    "integration/search.tfvars"
  ]

  variable_set_names = [
    "gcp-credentials-integration"
  ]

  depends_on = [
    module.variable-set-gcp-credentials-integration
  ]
}

module "search-production" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization      = var.organization
  workspace_name    = "search-production"
  workspace_desc    = "This module manages the provision of GCP Vertex AI Search resources."
  workspace_tags    = ["production", "search", "gcp"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/search/"
  trigger_patterns = [
    "/terraform/modules/search/**/*",
    "/terraform/variables/production/common.tfvars",
    "/terraform/variables/variables-common.tf",
    "/terraform/variables/production/search.tfvars"
  ]
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  tfvars_files = [
    "production/common.tfvars",
    "production/search.tfvars"
  ]

  variable_set_names = [
    "gcp-credentials-production"
  ]

  depends_on = [
    module.variable-set-gcp-credentials-production
  ]
}

module "search-secrets-production" {
  source = "github.com/alphagov/terraform-govuk-tfe-workspacer"

  organization      = var.organization
  workspace_name    = "search-secrets-production"
  workspace_desc    = "This module manages the AWS secrets required to access GCP Vertex AI Search."
  workspace_tags    = ["production", "search-secrets", "eks", "aws"]
  terraform_version = var.terraform_version
  execution_mode    = "remote"
  working_directory = "/terraform/modules/search-secrets/"
  trigger_patterns = [
    "/terraform/modules/search-secrets/**/*",
    "/terraform/variables/production/common.tfvars",
    "/terraform/variables/variables-common.tf",
    "/terraform/variables/production/search-secrets.tfvars"
  ]
  global_remote_state = true

  project_name = "publishing-platform-infrastructure"

  vcs_repo = {
    identifier     = "publishing-platform/publishing-platform-infrastructure"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  tfvars_files = [
    "production/common.tfvars",
    "production/search-secrets.tfvars"
  ]

  variable_set_names = [
    "aws-credentials-production"
  ]

  depends_on = [
    module.variable-set-aws-credentials-production
  ]
}
