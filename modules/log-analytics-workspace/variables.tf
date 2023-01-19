variable "azure_log_analytics_workspace" {
  description = "Azure log analytics workspace attributes"
  type = object({
    name                               = string
    unique_name                        = optional(bool)
    daily_quota_gb                     = optional(number) // -1 (unlimited)
    internet_ingestion_enabled         = optional(bool)
    internet_query_enabled             = optional(bool)
    location                           = string
    reservation_capacity_in_gb_per_day = optional(number) // Must be increments of 100 between 100 and 5000
    resource_group_name                = string
    retention_in_days                  = optional(number) // Either 7 for free tier only or a range between 30 and 730
    sku                                = optional(string) // Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, PerGB2018
    tags                               = optional(map(string))
    use_existing_workspace = optional(object({
      name                = string
      resource_group_name = string
    }))
    linked_storage_account = optional(object({
      data_source_type    = string
      storage_account_ids = list(string)
    }))
  })

  default = null
}

variable "azure_log_analytics_creds" {
  description = "Credentials for the Azure log analytics workspace"
  type = object({
    AAD_TENANT_ID     = string
    AAD_CLIENT_ID     = string
    AAD_CLIENT_SECRET = string
    AAD_PRINCIPAL_ID  = string
  })
  sensitive = true
  nullable  = false
}

variable "hpcc" {
  description = "HPCC Platform attributes"
  type = object({
    version   = string
    namespace = string
  })
  nullable = false
}

variable "subnet_id" {
  description = "The subnet ID of the VNet from which adresses must be allocated."
  type        = string

  default = null
}
