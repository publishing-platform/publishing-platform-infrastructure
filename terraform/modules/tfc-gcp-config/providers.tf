provider "tfe" {
  hostname     = var.tfc_hostname
  organization = var.organization
}

provider "random" {}