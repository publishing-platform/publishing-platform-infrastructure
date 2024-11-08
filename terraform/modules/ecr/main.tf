data "github_repositories" "publishing_platform" {
  query = "org:publishing-platform topic:container topic:publishing-platform fork:false archived:false"
}

resource "aws_ecr_repository" "github_repositories" {
  for_each             = toset(data.github_repositories.publishing_platform.names)
  name                 = "github/publishing-platform/${each.key}"
  image_tag_mutability = "MUTABLE" # To support a movable `latest` for developer convenience.
  image_scanning_configuration { scan_on_push = true }
}

resource "aws_secretsmanager_secret" "ecr_pullthroughcache_github" {
  name = "ecr-pullthroughcache/github-packages"

  recovery_window_in_days = 7
}

// this will fail until the ecr_pullthroughcache_github secret has a value set
resource "aws_ecr_pull_through_cache_rule" "github" {
  ecr_repository_prefix = "github"
  upstream_registry_url = "ghcr.io"
  credential_arn        = aws_secretsmanager_secret.ecr_pullthroughcache_github.arn

  depends_on = [aws_secretsmanager_secret.ecr_pullthroughcache_github]
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  for_each   = toset([for repo in data.github_repositories.publishing_platform.names : aws_ecr_repository.github_repositories[repo].name])
  repository = each.key

  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Keep last 20 images with tag prefix deployed-to",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["deployed-to"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 20
        },
        "action" : { "type" : "expire" }
      },
      {
        "rulePriority" : 2,
        "description" : "Expire untagged images older than 1 day",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : { "type" : "expire" }
      },
      {
        "rulePriority" : 4,
        "description" : "Keep last 20 images with tag prefix v",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["v"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 20
        },
        "action" : { "type" : "expire" }
      },
      {
        "rulePriority" : 5,
        "description" : "Expire images older than 30 days",
        "selection" : {
          "tagStatus" : "any",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 30
        },
        "action" : { "type" : "expire" }
      }
    ]
  })
}