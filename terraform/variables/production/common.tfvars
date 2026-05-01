# Common variables for the production environment.
# Only add variables here if they are shared across multiple workspaces in the production environment.
# Variables that are only used by a single workspace should be added to that workspace's specific tfvars file.

publishing_platform_environment = "production"
publishing_service_domain       = "production.publishing.service.publishing-platform.co.uk"

vpc_cidr = "10.13.0.0/16"