provider "azurerm" {
  features {}
}

provider "http" {}

data "azurerm_subscription" "current" {
}

module "subscription" {
  source          = "github.com/Azure-Terraform/terraform-azurerm-subscription-data.git?ref=v1.0.0"
  subscription_id = data.azurerm_subscription.current.subscription_id
}

module "naming" {
  source = "github.com/Azure-Terraform/example-naming-template.git?ref=v1.0.0"
}

module "metadata" {
  source = "github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.1"

  naming_rules = module.naming.yaml

  market              = var.metadata.market
  location            = var.location
  sre_team            = var.metadata.sre_team
  environment         = var.metadata.environment
  product_name        = var.metadata.product_name
  business_unit       = var.metadata.business_unit
  product_group       = var.metadata.product_group
  subscription_type   = var.metadata.subscription_type
  resource_group_type = var.metadata.resource_group_type
  subscription_id     = data.azurerm_subscription.current.subscription_id
  project             = var.metadata.project
}

module "resource_group" {
  source = "github.com/Azure-Terraform/terraform-azurerm-resource-group.git?ref=v2.0.0"

  unique_name = true
  location    = var.location
  names       = module.metadata.names
  tags        = merge(var.metadata.tags, var.azure_log_analytics_workspace.tags)
}

module "azure_log_analytics_workspace" {
  source = "../terraform-azurerm-hpcc-logging"

  azure_log_analytics_workspace = {
    unique_name                        = true
    daily_quota_gb                     = var.azure_log_analytics_workspace.daily_quota_gb
    internet_ingestion_enabled         = var.azure_log_analytics_workspace.internet_ingestion_enabled
    internet_query_enabled             = var.azure_log_analytics_workspace.internet_query_enabled
    location                           = var.location
    name                               = var.azure_log_analytics_workspace.name
    resource_group_name                = module.resource_group.name
    reservation_capacity_in_gb_per_day = var.azure_log_analytics_workspace.reservation_capacity_in_gb_per_day
    retention_in_days                  = var.azure_log_analytics_workspace.retention_in_days
    sku                                = var.azure_log_analytics_workspace.sku
    use_existing_workspace             = var.azure_log_analytics_workspace.use_existing_workspace
    tags                               = var.azure_log_analytics_workspace.tags
  }

  // Should be set as an environment variable or stored in a key vault
  azure_log_analytics_creds = {
    AAD_CLIENT_ID     = var.azure_log_analytics_creds.AAD_CLIENT_ID
    AAD_CLIENT_SECRET = var.azure_log_analytics_creds.AAD_CLIENT_SECRET
    AAD_TENANT_ID     = var.azure_log_analytics_creds.AAD_TENANT_ID
    AAD_PRINCIPAL_ID  = var.azure_log_analytics_creds.AAD_PRINCIPAL_ID
  }

  hpcc = {
    namespace = var.hpcc.namespace
    version   = var.hpcc.version
  }
}
