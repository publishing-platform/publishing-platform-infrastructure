// Allows accounts (e.g. Staging, Integration etc) to access ECR images in Production account.
// See https://platformers.dev/log/2023/ecr-cross-account-pull-through-cache/

data "aws_iam_policy_document" "allow_cross_account_pull_from_ecr" {
  statement {
    sid    = "AllowCrossAccountPull"
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage",
    ]
    principals {
      identifiers = var.puller_arns
      type        = "AWS"
    }
  }
}

resource "aws_ecr_repository_policy" "pull_from_ecr" {
  for_each   = toset([for repo in data.github_repositories.publishing_platform.names : aws_ecr_repository.github_repositories[repo].name])
  repository = each.key
  policy     = data.aws_iam_policy_document.allow_cross_account_pull_from_ecr.json
}