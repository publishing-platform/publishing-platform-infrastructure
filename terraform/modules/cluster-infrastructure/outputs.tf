output "cluster_id" {
  description = "The name (also known as the ID) of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded certificate data required to communicate with the cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's kube-apiserver."
  value       = module.eks.cluster_endpoint
}

output "node_security_group_id" {
  description = "ID of the security group which contains the worker nodes. May or may not be the same as control_plane_security_group_id."
  value       = module.eks.cluster_primary_security_group_id
}

output "aws_lb_controller_role_arn" {
  description = "IAM role ARN corresponding to the k8s service account for the AWS Load Balancer Controller."
  value       = module.aws_lb_controller_iam_role.iam_role_arn
}

output "aws_lb_controller_service_account_name" {
  description = "Name of the k8s service account for the AWS Load Balancer Controller."
  value       = local.aws_lb_controller_service_account_name
}