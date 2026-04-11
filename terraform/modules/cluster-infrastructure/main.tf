locals {
  cluster_services_namespace = "cluster-services"
  monitoring_namespace       = "monitoring"
  secrets_prefix             = "publishing-platform"

  default_block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = var.node_disk_size
        volume_type           = "gp3"
        encrypted             = true
        delete_on_termination = true
      }
    }
  }

  managed_node_group_defaults = {
    capacity_type                  = var.workers_default_capacity_type
    subnet_ids                     = [for s in aws_subnet.eks_private : s.id]
    create_security_group          = false
    create_iam_role                = false
    iam_role_arn                   = aws_iam_role.node.arn
    enable_efa_only                = false
    use_latest_ami_release_version = false
  }

  x86_managed_node_group = {
    x86 = merge(
      local.managed_node_group_defaults,
      {
        ami_type              = "AL2023_x86_64_STANDARD"
        name_prefix           = var.cluster_name
        desired_size          = var.workers_size_desired
        max_size              = var.workers_size_max
        min_size              = var.workers_size_min
        instance_types        = var.workers_instance_types
        update_config         = { max_unavailable = 1 }
        block_device_mappings = local.default_block_device_mappings
        additional_tags = {
          "k8s.io/cluster-autoscaler/enabled"             = "true"
          "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
        }
      }
    )
  }
}

data "aws_iam_policy_document" "node_assumerole" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "node" {
  name                  = "publishing-platform-eks-node-group"
  description           = "EKS managed node group IAM role"
  assume_role_policy    = data.aws_iam_policy_document.node_assumerole.json
  force_detach_policies = true
}

data "aws_iam_policy_document" "pull_from_ecr" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings"
    ]

    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "pull_from_ecr" {
  name        = "pull-from-ecr"
  description = "Policy to allows EKS to pull images from ECR"
  policy      = data.aws_iam_policy_document.pull_from_ecr.json
}

resource "aws_iam_role_policy_attachment" "pull_from_ecr" {
  policy_arn = aws_iam_policy.pull_from_ecr.arn
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node" {
  for_each = toset([
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonSSMManagedInstanceCore",
  ])
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
  role       = aws_iam_role.node.name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version
  subnet_ids         = [for s in aws_subnet.eks_control_plane : s.id]
  vpc_id             = data.tfe_outputs.vpc.nonsensitive_values.vpc_id

  addons = {
    coredns    = { most_recent = true, resolve_conflicts_on_create = "OVERWRITE" }
    kube-proxy = { most_recent = true, resolve_conflicts_on_create = "OVERWRITE" }
    vpc-cni    = { most_recent = true, resolve_conflicts_on_create = "OVERWRITE" }
  }

  endpoint_public_access                 = true
  cloudwatch_log_group_retention_in_days = var.cluster_log_retention_in_days
  enabled_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  encryption_config = {
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }
  create_kms_key                = false
  kms_key_enable_default_policy = false

  # We're just using the cluster primary SG as created by EKS.
  create_security_group      = false
  create_node_security_group = false

  authentication_mode = "API_AND_CONFIG_MAP" # see https://github.com/terraform-aws-modules/terraform-aws-eks/issues/3026

  eks_managed_node_groups = local.x86_managed_node_group

  access_entries = {
    admin = {
      principal_arn = one(data.aws_iam_roles.admin.arns)

      policy_associations = {
        this = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" # https://docs.aws.amazon.com/eks/latest/userguide/cluster-auth.html, https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html
          access_scope = {
            type = "cluster"
          }
        }
      }
    }

    tfc = {
      principal_arn = one(data.aws_iam_roles.tfc.arns)

      policy_associations = {
        this = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy" # https://docs.aws.amazon.com/eks/latest/userguide/cluster-auth.html, https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}