# Applying Terraform

The EKS cluster is deployed via Terraform in two stages.

- `cluster-infrastructure` is concerned only with setting-up the EKS cluster and associated AWS resources (such as the worker groups and auto-scaling groups).
- `cluster-services` is concerned only with setting up the Kubernetes resources and configuration for base services, e.g. aws load balancer controller, argocd etc.

## Prerequisites

1. `cluster-services` deployment requires some [prerequisite secrets](../docs/prerequisite-secrets.md)
which are not generated automatically. Create these secrets before running
the Terraform apply for the first time.

## Deployment

When turning up from scratch, deploy the modules in this order:

1. [`tfc-bootstrap`](./modules/tfc-bootstrap/) (execute locally)
2. [`tfc-configuration`](./modules/tfc-configuration/)
3. [`tfc-aws-config`](./modules/tfc-aws-config/) (execute locally)
4. [`vpc`](./modules/vpc/)
5. [`github`](./modules/github/)
6. [`ecr`](./modules/ecr/)
5. [`cluster-infrastructure`](./modules/cluster-infrastructure/)
6. [`rds`](./modules/rds/)
7. TODO