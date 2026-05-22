# Some resources have been moved to shared module temporarily to decouple from this module

# data "aws_route53_zone" "internal" {
#   name = "${var.publishing_platform_environment}.publishing-platform-internal.top"
#   tags = {
#     Repository = "publishing-platform-infrastructure"
#   }
#   private_zone = true
# }

resource "aws_security_group" "assets_efs" {
  name        = "asset-manager-efs"
  vpc_id      = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
  description = "Security group for asset-manager EFS volume"
}

resource "aws_security_group_rule" "assets_efs" {
  description              = "Allow EKS nodes to access NFS port"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = aws_security_group.assets_efs.id
  source_security_group_id = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.node_security_group_id
}

# resource "aws_efs_file_system" "assets_efs" {
#   creation_token = "blue-assets"
#   tags = {
#     "Name"        = "asset-manager"
#     "Description" = "ClamAV database configuration is stored here. Asset Manager attachments are stored here temporarily for malware scanning before being transferred to S3."
#   }
# }

resource "aws_efs_mount_target" "assets_efs" {
  for_each = toset(data.tfe_outputs.cluster_infrastructure.nonsensitive_values.private_subnets)
  # file_system_id  = aws_efs_file_system.assets_efs.id
  file_system_id  = data.tfe_outputs.shared.nonsensitive_values.assets_efs_id
  subnet_id       = each.key
  security_groups = [aws_security_group.assets_efs.id]
}

# resource "aws_route53_record" "assets_efs" {
#   zone_id = data.aws_route53_zone.internal.zone_id
#   name    = "assets.${data.aws_route53_zone.internal.name}"
#   type    = "CNAME"
#   records = [aws_efs_file_system.assets_efs.dns_name]
#   ttl     = 300
# }