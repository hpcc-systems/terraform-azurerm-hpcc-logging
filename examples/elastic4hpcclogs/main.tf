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

module "elastic4hpcclogs" {
  source = "../terraform-azurerm-hpcc-logging"

  elastic4hpcclogs = {
    internet_enabled           = true
    name                       = "myelastic4hpcclogs"
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
