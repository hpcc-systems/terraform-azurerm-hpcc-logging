output "logaccess_body" {
  description = "logaccess configuration to apply to the HPCC helm deployment."
  value       = data.http.hpcc-logaccess.response_body
}
