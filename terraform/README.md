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

1. [`tfc-bootstrap`](./modules/tfc-bootstrap/) (execute locally) *
2. [`tfc-configuration`](./modules/tfc-configuration/) *
3. [`tfc-aws-config`](./modules/tfc-aws-config/) (execute locally) *
4. [`github`](./modules/github/) *
5. [`sentry`](./modules/sentry/) *
6. [`ses`](./modules/ses/) *
7. [`vpc`](./modules/vpc/) *
8. [`certificates`](./modules/certificates/) *
9. [`rds`](./modules/rds/) *
10. [`shared`](./modules/shared/) *
11. [`waf`](./modules/waf/)
12. [`ecr`](./modules/ecr/)
13. [`cluster-infrastructure`](./modules/cluster-infrastructure/)
14. [`rds-security`](./modules/rds-security/)
15. [`publishing-infrastructure`](./modules/publishing-infrastructure/)
16. [`cluster-services`](./modules/cluster-services/)

\* Destroy plan is not allowed

## Destroying
When destroying an environment run the destroy plans in reverse order.

## Troubleshooting
- When destroying `cluster-infrastructure` you may receive the following error message:

    ```
    Error: deleting EC2 Subnet (subnet-xxx): operation error EC2: DeleteSubnet, https response error StatusCode: 400, RequestID: 4f6d96be-ddc1-4458-9b64-054b031722bf, api error DependencyViolation: The subnet 'subnet-xxx' has dependencies and cannot be deleted.
    ```

    The Kubernetes cluster has created EC2 Load Balancers and Elastic Network Interfaces (ENI) in this subnet.  Because they are not managed by Terraform they will need to be manually deleted before the destroy plan will succeed.