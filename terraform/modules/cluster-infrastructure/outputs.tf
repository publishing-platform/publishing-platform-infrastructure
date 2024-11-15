output "node_security_group_id" {
  description = "ID of the security group which contains the worker nodes. May or may not be the same as control_plane_security_group_id."
  value       = module.eks.cluster_primary_security_group_id
}