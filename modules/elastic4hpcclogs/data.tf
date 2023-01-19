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
