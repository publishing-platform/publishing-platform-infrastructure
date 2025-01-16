output "rds_security_groups" {
  description = "A map of RDS instance security groups"
  value       = { for k, v in aws_security_group.rds : k => v.id }
}
