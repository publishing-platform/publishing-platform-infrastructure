module "variable-set-production" {
  source = "./variable-set"

  name         = "common-production"
  organization = var.organization
  tfvars = {
    publishing_platform_environment = "production"
    publishing_service_domain       = "production.publishing.service.publishing-platform.co.uk"

    cluster_version               = "1.31"
    cluster_log_retention_in_days = 7

    vpc_cidr = "10.13.0.0/16"

    eks_control_plane_subnets = {
      a = { az = "eu-west-2a", cidr = "10.13.19.0/28" }
      b = { az = "eu-west-2b", cidr = "10.13.19.16/28" }
      c = { az = "eu-west-2c", cidr = "10.13.19.32/28" }
    }

    eks_public_subnets = {
      a = { az = "eu-west-2a", cidr = "10.13.20.0/24" }
      b = { az = "eu-west-2b", cidr = "10.13.21.0/24" }
      c = { az = "eu-west-2c", cidr = "10.13.22.0/24" }
    }

    eks_private_subnets = {
      a = { az = "eu-west-2a", cidr = "10.13.24.0/22" }
      b = { az = "eu-west-2b", cidr = "10.13.28.0/22" }
      c = { az = "eu-west-2c", cidr = "10.13.32.0/22" }
    }
  }
}

module "variable-set-ecr-production" {
  source = "./variable-set"

  name         = "ecr-production"
  organization = var.organization
  tfvars = {
  }
}

# This has to be separate because the ':' get replaced with '='
#  by the var set module
resource "tfe_variable" "ecr-puller-arns" {
  variable_set_id = module.variable-set-ecr-production.variable_set_id
  key             = "puller_arns"
  category        = "terraform"
  value = jsonencode(
    [
      "arn:aws:iam::761018850167:root", # Production
      # "arn:aws:iam::xxxxxxxxxxxx:root", # Staging
      # "arn:aws:iam::xxxxxxxxxxxx:root", # Integration
      # "arn:aws:iam::xxxxxxxxxxxx:root", # Test
    ]
  )
  hcl = true
}

module "variable-set-github-production" {
  source = "./variable-set"

  name         = "github-production"
  organization = var.organization
  tfvars = {
  }
}

module "variable-set-aws-credentials-production" {
  source = "./variable-set"

  name         = "aws-credentials-production"
  organization = var.organization
  tfvars = {
  }
}

module "variable-set-rds-production" {
  source = "./variable-set"

  name         = "rds-production"
  organization = var.organization
  tfvars = {
    backup_retention_period = 0     # 7 in production
    skip_final_snapshot     = true  # false in production
    multi_az                = false # true in production
    apply_immediately       = true  # false in production
    deletion_protection     = false # true in production

    databases = {
      # in production each app would have its own database instance
      # e.g.

      # content_store = {
      #   engine         = "postgres"
      #   engine_version = "13"
      #   engine_params = {
      #     log_min_duration_statement = { value = 10000 }
      #     log_statement              = { value = "all" }
      #     deadlock_timeout           = { value = 2500 }
      #     log_lock_waits             = { value = 1 }
      #   }
      #   engine_params_family         = "postgres14"
      #   name                         = "content-store"
      #   allocated_storage            = 1000
      #   instance_class               = "db.m6g.2xlarge"
      #   performance_insights_enabled = true
      #   freestoragespace_threshold   = 10737418240
      #   project                      = "Publishing Platform"
      # }

      # publisher = {
      #   engine         = "postgres"
      #   engine_version = "13"
      #   engine_params = {
      #     log_min_duration_statement = { value = 10000 }
      #     log_statement              = { value = "all" }
      #     deadlock_timeout           = { value = 2500 }
      #     log_lock_waits             = { value = 1 }
      #   }
      #   engine_params_family         = "postgres13"
      #   name                         = "publisher"
      #   allocated_storage            = 100
      #   instance_class               = "db.t4g.medium"
      #   performance_insights_enabled = true
      #   freestoragespace_threshold   = 10737418240
      #   project                      = "Publishing Platform"
      # }      
      publishing_platform = {
        engine         = "postgres"
        engine_version = "13"
        engine_params = {
          log_min_duration_statement = { value = 10000 }
          log_statement              = { value = "all" }
          deadlock_timeout           = { value = 2500 }
          log_lock_waits             = { value = 1 }
        }
        engine_params_family         = "postgres13"
        name                         = "publishing-platform"
        allocated_storage            = 20
        instance_class               = "db.t4g.small"
        performance_insights_enabled = true
        freestoragespace_threshold   = 10737418240 # bytes (10 GB)
        project                      = "Publishing Platform"
      }
    }

    rds_private_subnets = {
      a = { az = "eu-west-2a", cidr = "10.13.40.0/24" }
      b = { az = "eu-west-2b", cidr = "10.13.41.0/24" }
      c = { az = "eu-west-2c", cidr = "10.13.42.0/24" }
    }
  }
}

module "variable-set-waf-production" {
  source = "./variable-set"

  name         = "waf-production"
  organization = var.organization
  tfvars = {
    waf_log_retention_days = 30
  }
}

module "variable-set-ses-production" {
  source = "./variable-set"

  name         = "ses-production"
  organization = var.organization
  tfvars = {
  }
}