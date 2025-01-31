output "dkim_records" {
  description = "A map of DKIM records"
  value       = { for v in aws_ses_domain_dkim.dkim_identity.dkim_tokens : "${v}._domainkey.${aws_ses_domain_identity.domain_identity.domain}" => "${v}.dkim.amazonses.com" }
}

output "smtp_username" {
  value = aws_iam_access_key.smtp.id
}

output "smtp_password" {
  sensitive = true
  value     = aws_iam_access_key.smtp.ses_smtp_password_v4
}