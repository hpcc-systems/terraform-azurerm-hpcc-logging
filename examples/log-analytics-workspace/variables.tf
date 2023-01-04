variable "metadata" {
  description = "Metadata module variables."
  type = object({
    market              = string
    sre_team            = string
    environment         = string
    product_name        = string
    business_unit       = string
    product_group       = string
    subscription_type   = string
    resource_group_type = string
    project             = string
    tags                = optional(map(string))
  })

  default = {
    business_unit       = ""
    environment         = ""
    market              = ""
    product_group       = ""
    product_name        = "hpcc"
    project             = ""
    resource_group_type = ""
    sre_team            = ""
    subscription_type   = ""
  }
}

variable "location" {
  description = "Azure location"
  type        = string

  default = "eastus2"
}

variable "azure_log_analytics_workspace" {
  description = "Azure log analytics workspace attributes"
  type = object({
    unique_name                        = optional(bool)
    name                               = string
    daily_quota_gb                     = optional(number)
    internet_ingestion_enabled         = optional(bool)
    internet_query_enabled             = optional(bool)
    reservation_capacity_in_gb_per_day = optional(number)
    retention_in_days                  = optional(number)
    sku                                = optional(string)
    tags                               = optional(map(string))
    use_existing_workspace = optional(object({
      name                = string
      resource_group_name = string
    }))
  })

  default = {
    name        = "my-hpcc-log-analytics-workspace"
    unique_name = true
  }
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

  default = null
}

variable "hpcc" {
  description = "HPCC Platform attributes"
  type = object({
    version   = string
    namespace = string
  })

  default = {
    namespace = "default"
    version   = "8.10.12-rc1"
  }
}
