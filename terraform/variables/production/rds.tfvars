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
    engine_version = "14"
    engine_params = {
      log_min_duration_statement = { value = 10000 }
      log_statement              = { value = "all" }
      deadlock_timeout           = { value = 2500 }
      log_lock_waits             = { value = 1 }
    }
    engine_params_family         = "postgres14"
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