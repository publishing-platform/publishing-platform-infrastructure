output "rds_security_groups" {
  description = "A map of database security groups"
  value       = aws_security_group.rds
}
