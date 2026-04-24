module "tfc-aws-config-production" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.15.0"

  organization        = var.organization
  workspace_name      = "tfc-aws-config-production"
  workspace_desc      = "Sets up the OpenID Connect authentication and AWS IAM authorisation for the publishing-platform Terraform Cloud org to manage resources in the Publishing Platform AWS accounts."
  workspace_tags      = ["production", "tfc", "aws", "configuration"]
  terraform_version   = var.terraform_version
  execution_mode      = "local"
  global_remote_state = true
  allow_destroy_plan  = false

  project_name = "tfc-configuration"
}