data "github_repositories" "publishing_platform" {
  query = "org:publishing-platform topic:container topic:publishing-platform fork:false archived:false"
}

resource "aws_secretsmanager_secret" "ecr_pullthroughcache_github" {
  name = "ecr-pullthroughcache/github"

  recovery_window_in_days = 7
}

resource "aws_ecr_pull_through_cache_rule" "github" {
  ecr_repository_prefix = "github"
  upstream_registry_url = "ghcr.io"
  credential_arn        = aws_secretsmanager_secret.ecr_pullthroughcache_github.arn

  depends_on = [aws_secretsmanager_secret.ecr_pullthroughcache_github]
}