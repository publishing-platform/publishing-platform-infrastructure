variable "discovery_engine_api_version" {
  type        = string
  description = "The version of the Discovery Engine API to use, e.g. v1alpha"
  # Defaulting to `v1alpha` as `v1beta` and `v1` APIs don't support all required features yet
  # (e.g. `completionConfig` management as of Jun 2025)
  default = "v1alpha"
}
