output "log_analytics_hpcc_logaccess_body" {
  value = data.http.hpcc-logaccess["loganalytics"].response_body
}

output "azure_log_analytics_workspace_id" {
  value = try(data.azurerm_log_analytics_workspace.hpcc[0].id, azurerm_log_analytics_workspace.hpcc[0].id)
}
