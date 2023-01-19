variable "hpcc" {
  description = "HPCC Platform attributes"
  type = object({
    version   = string
    namespace = string
  })

  nullable = false
}

variable "elastic4hpcclogs" {
  description = "The attributes for elastic4hpcclogs."
  type = object({
    internet_enabled           = optional(bool)
    name                       = string
    atomic                     = optional(bool)
    recreate_pods              = optional(bool)
    reuse_values               = optional(bool)
    reset_values               = optional(bool)
    force_update               = optional(bool)
    cleanup_on_fail            = optional(bool)
    disable_openapi_validation = optional(bool)
    max_history                = optional(number)
    wait                       = optional(bool)
    dependency_update          = optional(bool)
    timeout                    = optional(number)
    wait_for_jobs              = optional(bool)
    lint                       = optional(bool)
    remote_chart               = string
    local_chart                = optional(string)
    version                    = optional(string)
  })

  default = null
}
