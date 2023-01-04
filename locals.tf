locals {
  is_release_candidate = can(regex("rc.*", var.hpcc.version))
  hpcc_version         = local.is_release_candidate ? var.hpcc.version : "${var.hpcc.version}-1"
  hpcc_logaccess = {
    loganalytics = {
      source          = "https://raw.githubusercontent.com/hpcc-systems/HPCC-Platform/community_${local.hpcc_version}/helm/examples/azure/log-analytics/loganalytics-hpcc-logaccess.yaml"
      request_headers = { Accept = "text/plain; charset=utf-8" }
    }
  }
}
