output "log_analytics_hpcc_logaccess_body" {
  value = data.http.hpcc-logaccess["loganalytics"].response_body
}

output "azure_log_analytics_workspace_resource_id" {
  value = try(data.azurerm_log_analytics_workspace.hpcc[0].id, azurerm_log_analytics_workspace.hpcc[0].id)
}

output "azure_log_analytics_workspace_id" {
  value = try(data.azurerm_log_analytics_workspace.hpcc[0].id, azurerm_log_analytics_workspace.hpcc[0].id)
}

output "azure_log_analytics_workspace_primary_shared_key" {
  value = try(data.azurerm_log_analytics_workspace.hpcc[0].primary_shared_key, azurerm_log_analytics_workspace.hpcc[0].primary_shared_key)
}

output "azure_log_analytics_workspace_secondary_shared_key" {
  value = try(data.azurerm_log_analytics_workspace.hpcc[0].secondary_shared_key, azurerm_log_analytics_workspace.hpcc[0].secondary_shared_key)
}
