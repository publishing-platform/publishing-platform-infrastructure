# TODO: move to publishing-infrastructure

resource "aws_s3_bucket" "content_publisher_activestorage" {
  bucket = "publishing-platform-${var.publishing_platform_environment}-content-publisher-activestorage"
}

resource "aws_s3_bucket_replication_configuration" "content_publisher_activestorage" {
  bucket = aws_s3_bucket.content_publisher_activestorage.id
  role   = aws_iam_role.content_publisher_activestorage_replication_role.arn

  rule {
    id = "publishing-platform-content-publisher-activestorage-replication-whole-bucket-rule"
    # Enabled in all envs except integration
    status = var.publishing_platform_environment == "integration" ? "Disabled" : "Enabled"

    destination {
      bucket        = aws_s3_bucket.content_publisher_activestorage_replica.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_logging" "content_publisher_activestorage" {
  bucket        = aws_s3_bucket.content_publisher_activestorage.id
  target_bucket = "publishing-platform-${var.publishing_platform_environment}-aws-logging"
  target_prefix = "s3/publishing-platform-${var.publishing_platform_environment}-content-publisher-activestorage/"
}

resource "aws_s3_bucket_versioning" "content_publisher_activestorage" {
  bucket = aws_s3_bucket.content_publisher_activestorage.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket" "content_publisher_activestorage_replica" {
  bucket   = "publishing-platform-${var.publishing_platform_environment}-content-publisher-activestorage-replica"
  provider = aws.replica
}

resource "aws_s3_bucket_versioning" "content_publisher_activestorage_replica" {
  bucket   = aws_s3_bucket.content_publisher_activestorage_replica.id
  provider = aws.replica
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_lifecycle_configuration" "content_publisher_activestorage_replica" {
  bucket   = aws_s3_bucket.content_publisher_activestorage_replica.id
  provider = aws.replica

  rule {
    id = "whole_bucket_lifecycle_rule_integration"
    # Only enable in integration
    status = var.publishing_platform_environment == "integration" ? "Enabled" : "Disabled"

    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }
}