locals {
  is_release_candidate = can(regex("rc.*", var.hpcc.version))
  hpcc_version         = local.is_release_candidate ? var.hpcc.version : "${var.hpcc.version}-1"

  logaccess_config = {
    source          = "https://raw.githubusercontent.com/hpcc-systems/HPCC-Platform/community_${local.hpcc_version}/helm/managed/logging/elastic/elastic4hpcclogs-hpcc-logaccess.yaml"
    request_headers = { Accept = "text/plain; charset=utf-8" }
  }
}
