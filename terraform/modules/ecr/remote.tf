data "aws_caller_identity" "current" {}

data "github_repositories" "publishing_platform" {
  query = "org:publishing-platform topic:container topic:publishing-platform fork:false archived:false"
}