# tfc-aws-config

The `tfc-aws-config` module sets up the OpenID Connect authentication and AWS IAM authorisation for the publishing-platform Terraform Cloud org to manage resources in the Publishing Platform AWS accounts.

You must apply this module locally.

1. In a web browser login to Terraform Cloud and create a new workspace for each environment, e.g. `tfc-aws-config-test`, `tfc-aws-config-staging`, `tfc-aws-config-production`.
2. Set the execution mode of each workspace to Local
3. Tag each workspace with `tfc`, `aws`, and `configuration`
4. In your terminal login to Terraform Cloud

    ```
    $ terraform login
    ```
5. For each environment (e.g. test, staging, production) you will need to provide credentials for the corresponding AWS account. This can be done by setting environment variables, e.g. 

    ```
    $ export AWS_ACCESS_KEY_ID="xxxxx"
    $ export AWS_SECRET_ACCESS_KEY="xxxxx"  
    $ export AWS_SESSION_TOKEN="xxxxx"
    ```

    or using the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso).

    You can then select the corrsponding workspace and run `terraform apply`.

    ```    
    $ terraform workspace select tfc-aws-config-production
    $ terraform apply -var=publishing_platform_environment=production
    ```

