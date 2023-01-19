resource "helm_release" "elastic4hpcclogs" {
  name                       = var.elastic4hpcclogs.name
  namespace                  = var.hpcc.namespace
  chart                      = var.elastic4hpcclogs.remote_chart != null ? "elastic4hpcclogs" : var.elastic4hpcclogs.local_chart
  repository                 = var.elastic4hpcclogs.remote_chart != null ? var.elastic4hpcclogs.remote_chart : null
  version                    = var.elastic4hpcclogs.version != null ? var.elastic4hpcclogs.version : null
  values                     = try([for v in var.elastic4hpcclogs.values : file(v)], [])
  create_namespace           = true
  atomic                     = try(var.elastic4hpcclogs.atomic, false)
  force_update               = try(var.elastic4hpcclogs.force_update, false)
  recreate_pods              = try(var.elastic4hpcclogs.recreate_pods, false)
  reuse_values               = try(var.elastic4hpcclogs.reuse_values, false)
  reset_values               = try(var.elastic4hpcclogs.reset_values, false)
  cleanup_on_fail            = try(var.elastic4hpcclogs.cleanup_on_fail, false)
  disable_openapi_validation = try(var.elastic4hpcclogs.disable_openapi_validation, false)
  wait                       = try(var.elastic4hpcclogs.wait, true)
  max_history                = try(var.elastic4hpcclogs.max_history, 0)
  dependency_update          = try(var.elastic4hpcclogs.dependency_update, false)
  timeout                    = try(var.elastic4hpcclogs.timeout, 900)
  wait_for_jobs              = try(var.elastic4hpcclogs.wait_for_jobs, false)
  lint                       = try(var.elastic4hpcclogs.lint, false)

  dynamic "set" {
    for_each = var.elastic4hpcclogs.internet_enabled ? [1] : []
    content {
      type  = "string"
      name  = "kibana.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
      value = tostring(false)
    }
  }
}
