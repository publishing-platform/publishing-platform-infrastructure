# tfc-aws-config

The `tfc-aws-config` module sets up the OpenID Connect authentication and AWS IAM authorisation for the publishing-platform Terraform Cloud org to manage resources in the Publishing Platform AWS accounts.

You must apply this module locally.

1. In your terminal login to Terraform Cloud

    ```
    $ terraform login
    ```
2. For each environment (e.g. test, staging, production) you will need to provide credentials for the corresponding AWS account. This can be done by setting environment variables, e.g. 

    ```
    $ export AWS_ACCESS_KEY_ID="xxxxx"
    $ export AWS_SECRET_ACCESS_KEY="xxxxx"  
    $ export AWS_SESSION_TOKEN="xxxxx"
    ```

    or using the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso).

3. You can then select the corresponding workspace and run `terraform apply`.

    ```    
    $ cd terraform/modules/tfc-aws-config
    $ terraform init
    $ terraform workspace select tfc-aws-config-production
    $ terraform apply -var=publishing_platform_environment=production
    ```

