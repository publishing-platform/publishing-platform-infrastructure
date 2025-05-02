# aws_lb_controller.tf manages the in-cluster components of the AWS Load
# Balancer Controller.
#
# The AWS IAM resources for the AWS LB Controller are in
# ../cluster-infrastructure/aws_lb_controller_iam.tf.

resource "helm_release" "aws_lb_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  version          = "1.12.0"
  namespace        = local.services_ns
  create_namespace = true
  timeout          = var.helm_timeout_seconds
  values = [yamlencode({
    clusterName        = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.cluster_id
    defaultSSLPolicy   = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    defaultTargetType  = "ip"
    ingressClass       = "aws-alb"
    ingressClassConfig = { default = true }
    ingressClassParams = { spec = { loadBalancerAttributes = [
      # TODO: factor out ALB attributes that are common to all of our ingresses.
      # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#load-balancer-attributes
    ] } }
    podDisruptionBudget = var.desired_ha_replicas > 1 ? { minAvailable = 1 } : {}
    replicaCount        = var.desired_ha_replicas
    region              = data.aws_region.current.name
    serviceMonitor      = { enabled = false } // TODO: set to true once there is a strategy for installing kube-prometheus-stack https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller#installing-the-prometheus-operator
    vpcId               = data.tfe_outputs.vpc.nonsensitive_values.vpc_id
    serviceAccount = {
      name = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.aws_lb_controller_service_account_name
      annotations = {
        "eks.amazonaws.com/role-arn" = data.tfe_outputs.cluster_infrastructure.nonsensitive_values.aws_lb_controller_role_arn
      }
    }
  })]
}