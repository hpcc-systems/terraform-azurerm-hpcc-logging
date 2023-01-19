output "logaccess_body" {
  description = "logaccess configuration to apply to the HPCC helm deployment."
  value       = data.http.hpcc-logaccess.response_body
}

output "workspace_resource_id" {
  description = "The resource ID of the workspace"
  value       = local.workspace.id
}

output "workspace_id" {
  description = "The Azure Analytics Workspace ID"
  value       = local.workspace.workspace_id
}

output "primary_shared_key" {
  description = "The primary shared key of the Azure Analytics Workspace"
  value       = local.workspace.primary_shared_key
}

output "secondary_shared_key" {
  description = "The secondary shared key of the Azure Analytics Workspace"
  value       = local.workspace.secondary_shared_key
}
