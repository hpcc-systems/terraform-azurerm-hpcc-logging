module "elastic4hpcclogs" {
  source = "./modules/elastic4hpcclogs"

  count = var.elastic4hpcclogs != null && var.azure_log_analytics_workspace == null ? 1 : 0

  elastic4hpcclogs = {
    internet_enabled           = var.elastic4hpcclogs.internet_enabled
    name                       = var.elastic4hpcclogs.name
    atomic                     = var.elastic4hpcclogs.atomic
    recreate_pods              = var.elastic4hpcclogs.recreate_pods
    reuse_values               = var.elastic4hpcclogs.reuse_values
    reset_values               = var.elastic4hpcclogs.reset_values
    force_update               = var.elastic4hpcclogs.force_update
    cleanup_on_fail            = var.elastic4hpcclogs.cleanup_on_fail
    disable_openapi_validation = var.elastic4hpcclogs.disable_openapi_validation
    max_history                = var.elastic4hpcclogs.max_history
    wait                       = var.elastic4hpcclogs.wait
    dependency_update          = var.elastic4hpcclogs.dependency_update
    timeout                    = var.elastic4hpcclogs.timeout
    wait_for_jobs              = var.elastic4hpcclogs.wait_for_jobs
    lint                       = var.elastic4hpcclogs.lint
    remote_chart               = var.elastic4hpcclogs.remote_chart
    local_chart                = var.elastic4hpcclogs.local_chart
    version                    = var.elastic4hpcclogs.version
  }
  hpcc = {
    namespace = var.hpcc.namespace
    version   = var.hpcc.version
  }
}

module "log-analytics-workspace" {
  source = "./modules/log-analytics-workspace"

  count = var.azure_log_analytics_workspace != null && var.elastic4hpcclogs == null ? 1 : 0

  azure_log_analytics_workspace = {
    unique_name                        = try(var.azure_log_analytics_workspace.unique_name, false)
    daily_quota_gb                     = try(var.azure_log_analytics_workspace.daily_quota_gb, null)
    internet_ingestion_enabled         = try(var.azure_log_analytics_workspace.internet_ingestion_enabled, null)
    internet_query_enabled             = try(var.azure_log_analytics_workspace.internet_query_enabled, null)
    location                           = var.azure_log_analytics_workspace.location
    name                               = var.azure_log_analytics_workspace.name
    resource_group_name                = var.azure_log_analytics_workspace.resource_group_name
    reservation_capacity_in_gb_per_day = try(var.azure_log_analytics_workspace.reservation_capacity_in_gb_per_day, null)
    retention_in_days                  = try(var.azure_log_analytics_workspace.retention_in_days, null)
    sku                                = try(var.azure_log_analytics_workspace.sku, null)
    use_existing_workspace             = try(var.azure_log_analytics_workspace.use_existing_workspace, null)
    tags                               = try(var.azure_log_analytics_workspace.tags, null)
    use_existing_role_assignment       = var.azure_log_analytics_workspace.use_existing_role_assignment
    use_existing_workspace             = var.azure_log_analytics_workspace.use_existing_workspace
    linked_storage_account             = var.azure_log_analytics_workspace.linked_storage_account
  }

  // Should be set as an environment variable 
  azure_log_analytics_creds = {
    AAD_CLIENT_ID     = var.azure_log_analytics_creds.AAD_CLIENT_ID
    AAD_CLIENT_SECRET = var.azure_log_analytics_creds.AAD_CLIENT_SECRET
    AAD_TENANT_ID     = var.azure_log_analytics_creds.AAD_TENANT_ID
    AAD_PRINCIPAL_ID  = var.azure_log_analytics_creds.AAD_PRINCIPAL_ID
  }

  subnet_id = var.subnet_id

  hpcc = {
    namespace = var.hpcc.namespace
    version   = var.hpcc.version
  }
}
