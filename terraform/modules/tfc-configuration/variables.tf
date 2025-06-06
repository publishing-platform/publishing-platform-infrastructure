#
# Organisation
#

variable "organization" {
  type        = string
  description = "Name of TFC Organization that the workspace will belong to"
  default     = "publishing-platform"
}

#
# Projects
#

variable "project_names" {
  description = "List of project names"
  type        = list(string)
  default     = ["publishing-platform-infrastructure"]
}

#
# Workspace
#

variable "terraform_version" {
  type        = string
  description = "Version constraint for Terraform for this workspace."
  default     = "~> 1.10.5"
}