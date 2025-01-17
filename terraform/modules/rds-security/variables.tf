variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "databases" {
  type        = map(any)
  description = "Databases to create and their configuration."
}