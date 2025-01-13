variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "waf_log_retention_days" {
  type        = number
  description = "The number of days CloudWatch will retain WAF logs for."
}

variable "backend_public_base_rate_warning" {
  type        = number
  description = "For the backend ALB. Allows us to configure a warning level to detect what happens if we reduce the limit."
}

variable "backend_public_base_rate_limit" {
  type        = string
  description = "For the backend ALB. Number of requests to allow in a 5 minute period before rate limiting is applied."
}

variable "cache_public_base_rate_warning" {
  type        = number
  description = "For the cache ALB. Allows us to configure a warning level to detect what happens if we reduce the limit."
}

variable "cache_public_base_rate_limit" {
  type        = number
  description = "For the cache ALB. Number of requests to allow in a 5 minute period before rate limiting is applied."
}