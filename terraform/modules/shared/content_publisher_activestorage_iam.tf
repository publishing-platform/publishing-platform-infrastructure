# TODO: move to publishing-infrastructure

# Replication IAM role/policy

data "aws_iam_policy_document" "content_publisher_activestorage_replication_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "content_publisher_activestorage_replication_role" {
  name               = "content-publisher-activestorage-replication-role"
  assume_role_policy = data.aws_iam_policy_document.content_publisher_activestorage_replication_role.json
}

data "aws_iam_policy_document" "content_publisher_activestorage_replication_policy" {
  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    resources = [aws_s3_bucket.content_publisher_activestorage.arn]
    effect    = "Allow"
  }
  statement {
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging"
    ]
    resources = ["${aws_s3_bucket.content_publisher_activestorage.arn}/*"]
    effect    = "Allow"
  }
  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete"
    ]
    resources = ["${aws_s3_bucket.content_publisher_activestorage_replica.arn}/*"]
  }
}

resource "aws_iam_policy" "content_publisher_activestorage_replication_policy" {
  name        = "publishing-platform-${var.publishing_platform_environment}-content-publisher-activestorage-replication-policy"
  policy      = data.aws_iam_policy_document.content_publisher_activestorage_replication_policy.json
  description = "Allows replication of the content publisher activestorage bucket"
}

resource "aws_iam_role_policy_attachment" "content_publisher_activestorage_replication_policy" {
  role       = aws_iam_role.content_publisher_activestorage_replication_role.name
  policy_arn = aws_iam_policy.content_publisher_activestorage_replication_policy.arn
}