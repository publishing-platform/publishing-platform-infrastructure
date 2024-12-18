data "aws_eks_cluster_auth" "cluster_token" {
  name = "publishing-platform"
}

provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Product     = "Publishing Platform"
      System      = "EKS cluster services"
      Environment = var.publishing_platform_environment
      Cluster     = var.cluster_name
      Repository  = "publishing-platform-infrastructure"
      Workspace   = terraform.workspace
    }
  }
}

provider "kubernetes" {
  host                   = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_endpoint
  cluster_ca_certificate = base64decode(data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster_token.token
}

provider "helm" {
  # TODO: If/when TF makes provider configs a first-class language object,
  # reuse the identical config from above.
  kubernetes {
    host                   = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_endpoint
    cluster_ca_certificate = base64decode(data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster_token.token
  }
}