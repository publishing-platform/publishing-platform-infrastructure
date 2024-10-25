variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster."
  default     = "publishing-platform"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes release version for the cluster, e.g. 1.21"
}

variable "cluster_log_retention_in_days" {
  type        = number
  description = "Number of days to retain cluster log events in CloudWatch."
}

variable "publishing_platform_environment" {
  type        = string
  description = "Publishing Platform environment where resources are being deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "eks_control_plane_subnets" {
  type        = map(object({ az = string, cidr = string }))
  description = "Map of {subnet_name: {az=<az>, cidr=<cidr>}} for the public subnets for the EKS cluster's apiserver."
}

variable "eks_private_subnets" {
  type        = map(object({ az = string, cidr = string }))
  description = "Map of {subnet_name: {az=<az>, cidr=<cidr>}} for the private subnets for the EKS cluster's nodes and pods."
}

variable "eks_public_subnets" {
  type        = map(object({ az = string, cidr = string }))
  description = "Map of {subnet_name: {az=<az>, cidr=<cidr>}} for the public subnets where the EKS cluster will create Internet-facing load balancers."
}

variable "workers_instance_types" {
  type        = list(string)
  description = "List of instance types for the managed node group, in order of preference. The second and subsequent preferences are only relevant when using spot instances."
  default     = ["t3.small"]
}

variable "workers_default_capacity_type" {
  type        = string
  description = "Default capacity type for managed node groups: SPOT or ON_DEMAND."
  default     = "ON_DEMAND"
}

variable "workers_size_desired" {
  type        = number
  description = "Desired capacity of managed node autoscale group."
  default     = 6
}

variable "workers_size_min" {
  type        = number
  description = "Min capacity of managed node autoscale group."
  default     = 3
}

variable "workers_size_max" {
  type        = number
  description = "Max capacity of managed node autoscale group."
  default     = 12
}

variable "node_disk_size" {
  type        = number
  description = "Size in GB of the node default volume"
  default     = 20
}
