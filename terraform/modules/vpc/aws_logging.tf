data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_aws_logging" {
  statement {
    actions   = ["s3:PutObject"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::publishing-platform-${var.publishing_platform_environment}-aws-logging/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }
  }
}

# Create a bucket that allows AWS services to write to it
resource "aws_s3_bucket" "aws_logging" {
  bucket = "publishing-platform-${var.publishing_platform_environment}-aws-logging"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "aws_logging" {
  bucket = aws_s3_bucket.aws_logging.id
  policy = data.aws_iam_policy_document.s3_aws_logging.json
}

resource "aws_s3_bucket_ownership_controls" "aws_logging" {
  bucket = aws_s3_bucket.aws_logging.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "aws_logging" {
  depends_on = [aws_s3_bucket_ownership_controls.aws_logging]

  bucket = aws_s3_bucket.aws_logging.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_lifecycle_configuration" "aws_logging" {
  bucket = aws_s3_bucket.aws_logging.id

  rule {
    id     = "ExpireRule"
    status = "Enabled"

    expiration {
      days = 30
    }
    noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }
}

resource "aws_s3_bucket_versioning" "aws_logging" {
  bucket = aws_s3_bucket.aws_logging.id

  versioning_configuration {
    status = "Enabled"
  }
}