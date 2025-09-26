# tfc-gcp-config

The `tfc-gcp-config` module creates GCP projects and configures Terraform Cloud as an external OIDC provider allowing the publishing-platform Terraform Cloud org to manage resources in GCP projects.

This module uses Terraform Cloud for remote state storage but you must apply this module locally. It is intended to be run by a user with "interactive" end-user access to both Terraform Cloud and Google Cloud Platform (so as to not have a chicken-and-egg problem around having to manually create service accounts to manage meta-resources like service accounts or projects).

1. In your terminal login to Terraform Cloud

    ```
    $ terraform login
    ```
2. Login to GCP

    ```
    $ gcloud auth application-default login
    ```

3. You can then select the corresponding workspace and run `terraform apply`.

    ```    
    $ cd terraform/modules/tfc-gcp-config
    $ terraform init
    $ terraform workspace select tfc-gcp-config-production
    $ terraform apply -var=publishing_platform_environment=production -var=google_cloud_folder=25482549648 -var=google_cloud_billing_account=030D27-E1C349-B2CCE3
    ```

