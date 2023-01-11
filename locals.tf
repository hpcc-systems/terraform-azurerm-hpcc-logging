locals {
  is_release_candidate = can(regex("rc.*", var.hpcc.version))
  hpcc_version         = local.is_release_candidate ? var.hpcc.version : "${var.hpcc.version}-1"
  hpcc_logaccess = {
    loganalytics = {
      source          = "https://raw.githubusercontent.com/hpcc-systems/HPCC-Platform/community_${local.hpcc_version}/helm/examples/azure/log-analytics/loganalytics-hpcc-logaccess.yaml"
      request_headers = { Accept = "text/plain; charset=utf-8" }
    }
  }

  privatelink_dns = {
    "privatelink-monitor-azure-com"             = "privatelink.monitor.azure.com",
    "privatelink-oms-opinsights-azure-com"      = "privatelink.oms.opinsights.azure.com",
    "privatelink-ods-opinsights-azure-com"      = "privatelink.ods.opinsights.azure.com",
    "privatelink-agentsvc-azure-automation-net" = "privatelink.agentsvc.azure-automation.net",
    "privatelink-blob-core-windows-net"         = "privatelink.blob.core.windows.net"
  }

  private_connection = var.azure_log_analytics_workspace.internet_ingestion_enabled == false || var.azure_log_analytics_workspace.internet_query_enabled == false ? true : false
}
