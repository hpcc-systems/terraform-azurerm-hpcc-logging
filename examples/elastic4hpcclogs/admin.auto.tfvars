metadata = {
  project             = "hpccdemo"
  product_name        = "aks"
  business_unit       = "commercial"
  environment         = "sandbox"
  market              = "us"
  product_group       = "contoso"
  resource_group_type = "app"
  sre_team            = "hpccplatform"
  subscription_type   = "dev"
  tags                = { "justification" = "testing" }
}

location = "eastus2"

azure_log_analytics_workspace = {
  name                       = "my-hpcc-log-analytics-workspace"
  internet_query_enabled     = true
  internet_ingestion_enabled = true
  tags = {
    "app" = "hpcc"
  }
}
