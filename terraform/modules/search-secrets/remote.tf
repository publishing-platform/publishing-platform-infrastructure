data "tfe_outputs" "search" {
  organization = "publishing-platform"
  workspace    = "search-${var.publishing_platform_environment}"
}

data "tfe_outputs" "tfc_gcp_config" {
  organization = "publishing-platform"
  workspace    = "tfc-gcp-config-${var.publishing_platform_environment}"
}