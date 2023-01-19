data "http" "hpcc-logaccess" {
  method          = "GET"
  request_headers = local.logaccess_config.request_headers
  url             = local.logaccess_config.source

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "\"${self.id}\" Not Found"
    }
  }
}

data "azurerm_log_analytics_workspace" "hpcc" {
  count = var.azure_log_analytics_workspace.use_existing_workspace != null ? 1 : 0

  name                = var.azure_log_analytics_workspace.use_existing_workspace.name
  resource_group_name = var.azure_log_analytics_workspace.use_existing_workspace.resource_group_name
}

data "azurerm_subscription" "current" {}
