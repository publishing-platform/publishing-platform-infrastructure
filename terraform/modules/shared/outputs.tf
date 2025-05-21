output "mq_user_passwords" {
  description = "A map of Amazon MQ user passwords"
  value       = { for user, pw in random_password.mq_user : user => pw.result }
  sensitive   = true
}
