output "backend_public_web_acl_arn" {
  description = "ARN corresponding to the backend public Web ACL."
  value       = aws_wafv2_web_acl.backend_public.arn
}

output "cache_public_web_acl_arn" {
  description = "ARN corresponding to the cache public Web ACL."
  value       = aws_wafv2_web_acl.cache_public.arn
}