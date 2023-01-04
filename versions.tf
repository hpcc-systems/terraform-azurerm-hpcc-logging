terraform {
  required_version = ">=1.3.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.85.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">=3.2.1"
    }
  }
}
