data "aws_eks_cluster_auth" "cluster_token" {
  name = "publishing-platform"
}

# provider "kubernetes" {
#   host                   = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_endpoint
#   cluster_ca_certificate = base64decode(data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.cluster_token.token
# }

# provider "helm" {
#   # TODO: If/when TF makes provider configs a first-class language object,
#   # reuse the identical config from above.
#   kubernetes {
#     host                   = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_endpoint
#     cluster_ca_certificate = base64decode(data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_certificate_authority_data)
#     token                  = data.aws_eks_cluster_auth.cluster_token.token
#   }
# }