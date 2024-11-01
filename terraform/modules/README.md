# Terraform for Publishing Platform EKS cluster

## Applying Terraform
When turning up from scratch, deploy the modules in this order:

1. [`tfc-aws-config`](./tfc-aws-config/)
2. [`tfc-bootstrap`](./tfc-bootstrap/)
3. [`tfc-configuration`](./tfc-configuration/)
4. [`vpc`](./vpc/)
5. [`cluster-infrastructure`](./cluster-infrastructure/)
6. TODO