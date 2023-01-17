locals {
  is_release_candidate = can(regex("rc.*", var.hpcc.version))
  hpcc_version         = local.is_release_candidate ? var.hpcc.version : "${var.hpcc.version}-1"

  logaccess_config = {
    source          = "https://raw.githubusercontent.com/hpcc-systems/HPCC-Platform/community_${local.hpcc_version}/helm/examples/azure/log-analytics/loganalytics-hpcc-logaccess.yaml"
    request_headers = { Accept = "text/plain; charset=utf-8" }
  }

  privatelink_dns = {
    "privatelink-monitor-azure-com"             = "privatelink.monitor.azure.com",
    "privatelink-oms-opinsights-azure-com"      = "privatelink.oms.opinsights.azure.com",
    "privatelink-ods-opinsights-azure-com"      = "privatelink.ods.opinsights.azure.com",
    "privatelink-agentsvc-azure-automation-net" = "privatelink.agentsvc.azure-automation.net",
    "privatelink-blob-core-windows-net"         = "privatelink.blob.core.windows.net"
  }

  workspace = var.azure_log_analytics_workspace.use_existing_workspace == null ? azurerm_log_analytics_workspace.hpcc[0] : data.azurerm_log_analytics_workspace.hpcc[0]

  private_connection = var.azure_log_analytics_workspace.internet_ingestion_enabled == false || var.azure_log_analytics_workspace.internet_query_enabled == false ? true : false
}
