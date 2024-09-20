#
# Organisation
#

variable "organisation" {
  type        = string
  description = "Name of TFC Organization that the workspace will belong to."
  default     = "publishing-platform"
}