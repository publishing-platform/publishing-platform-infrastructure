output "mq_user" {
  description = "A map of Amazon MQ user passwords"
  value       = { for user, pw in random_password.mq_user : user => pw.result }
  sensitive   = true
}

output "aws_s3_bucket_content_publisher_activestorage_arn" {
  description = "ARN corresponding to the content-publisher active storage s3 bucket."
  value       = aws_s3_bucket.content_publisher_activestorage.arn
}