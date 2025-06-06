# The cluster-services module is responsible for Kubernetes objects within the
# EKS cluster.
#
# Any AWS resources relating to the cluster belong in
# ../cluster-infrastructure, not in this module.

terraform {
  cloud {
    organization = "publishing-platform"
    workspaces {
      tags = ["cluster-services", "eks", "aws"]
    }
  }

  required_version = "~> 1.10"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
    }
  }
}