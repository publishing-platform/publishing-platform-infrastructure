# Common variables for the integration environment.
# Only add variables here if they are shared across multiple workspaces in the integration environment.
# Variables that are only used by a single workspace should be added to that workspace's specific tfvars file.

publishing_platform_environment = "integration"

vpc_cidr = "10.1.0.0/16"