variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "force_destroy" {
  type        = bool
  description = "Setting for force_destroy on resources such as S3 buckets and Route53 zones. For use in non-production environments to allow for automated tear-down."
  default     = false
}

variable "amazonmq_engine_version" {
  type        = string
  default     = "3.13"
  description = "Engine version for publishing AmazonMQ cluster"
}

variable "amazonmq_host_instance_type" {
  type        = string
  default     = "mq.t3.micro"
  description = "Instance size for publishing AmazonMQ cluster"
}

variable "amazonmq_deployment_mode" {
  type        = string
  default     = "SINGLE_INSTANCE"
  description = "SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ, or CLUSTER_MULTI_AZ"
}

variable "amazonmq_maintenance_window_start_day_of_week" {
  type        = string
  default     = "MONDAY"
  description = "Day of week for automated maintenance"
}

variable "amazonmq_maintenance_window_start_time_utc" {
  type        = string
  default     = "07:00"
  description = "Time to start automated maintenance"
}

variable "private_subnets" {
  type        = map(object({ az = string, cidr = string }))
  description = "Map of {subnet_name: {az=<az>, cidr=<cidr>}} for the private subnets."
}