output "mq_user" {
  description = "A map of Amazon MQ user passwords"
  value       = { for user, pw in random_password.mq_user : user => pw.result }
  sensitive   = true
}

output "aws_s3_bucket_content_publisher_activestorage_arn" {
  description = "ARN corresponding to the content-publisher active storage s3 bucket."
  value       = aws_s3_bucket.content_publisher_activestorage.arn
}

output "aws_s3_bucket_assets_arn" {
  description = "ARN corresponding to the asset manager s3 bucket."
  value       = aws_s3_bucket.assets.arn
}

output "assets_efs_id" {
  description = "ID corresponding to the asset manager EFS."
  value       = aws_efs_file_system.assets_efs.id
}