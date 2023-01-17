output "logaccess_body" {
  description = "logaccess configuration to apply to the HPCC helm deployment."
  value       = var.azure_log_analytics_workspace != null ? try(module.log-analytics-workspace[0].logaccess_body, null) : try(module.elastic4hpcclogs[0].logaccess_body, null)
}

output "workspace_resource_id" {
  description = "The resource ID of the workspace"
  value       = try(module.log-analytics-workspace[0].workspace_resource_id, null)
}

output "workspace_id" {
  description = "The Azure Analytics Workspace ID"
  value       = try(module.log-analytics-workspace[0].workspace_id, null)
}

output "primary_shared_key" {
  description = "The primary shared key of the Azure Analytics Workspace"
  value       = try(module.log-analytics-workspace[0].primary_shared_key, null)
}

output "secondary_shared_key" {
  description = "The secondary shared key of the Azure Analytics Workspace"
  value       = try(module.log-analytics-workspace[0].secondary_shared_key, null)
}

