provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "Elastic Container Registry"
      Environment = var.publishing_platform_environment
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}

# provider "github" {
#   owner = "publishing-platform"
#   token = data.aws_secretsmanager_secret_version.github-token.secret_string
# }