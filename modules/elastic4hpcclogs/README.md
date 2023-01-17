# terraform-azurerm-hpcc-logging
This module provides the Elastic4hpcclogs solution for the HPCC Platform.
<br/>
<br/>

## Requirements
This module requires an Azure Kubernetes Service.
<br/>

## Supported Arguments
<br/>

## `hpcc` object specifications

| **Variable** | **Description**                                                                        | **Type** | **Default** | **Required** |
| :----------- | :------------------------------------------------------------------------------------- | :------- | :---------- | :----------- |
| `namespace`  | Namespace name. This must be the namespace where HPCC Platform is or will be deployed. | `string` | `hpcc`      | `yes`        |
| `version`    | The HPCC Platform version.                                                             | `string` | `8.10.10`   | `yes`        |
<br/>

## `elastic4hpcclogs` object specifications

 | **Variable**                 | **Description**                                                                                                                                                                                                             | **Type**       | **Default** | **Required** |
 | ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------- | :----------: |
 | `local_chart`                | Path to local chart directory name or tgz file.  Example1: /Users/foo/work/demo/helm-chart/helm/managed/logging/elastic    Example2: https://github.com/hpcc-systems/helm-chart/raw/master/docs/elastic4hpcclogs-1.2.10.tgz | `string`       | `null`      |     `no`     |
 | `remote_chart`               | URL of the remote chart. Example: https://hpcc-systems.github.io/helm-chart                                                                                                                                                 | `string`       | `null`      |    `bool`    | `true` | no |
 | `name`                       | Release name of the chart.                                                                                                                                                                                                  | `string`       | `null`      |    `yes`     |
 | `version`                    | The version of the elastic4hpcclogs                                                                                                                                                                                         | `string`       | `1.2.8`     |              | `no`   |
 | `values`                     | List of desired state files to use similar to -f in CLI.                                                                                                                                                                    | `list(string)` | `null`      |     `no`     |
 | `atomic`                     | If set, installation process purges chart on fail. The `wait` flag will be set automatically if `atomic` is used.                                                                                                           | `bool`         | `false`     |     `no`     |
 | `recreate_pods`              | Perform pods restart during upgrade/rollback.                                                                                                                                                                               | `bool`         | `false`     |     `no`     |
 | `reuse_values`               | When upgrading, reuse the last release's values and merge in any overrides. If `reset_values` is specified, this is ignored.                                                                                                | `bool`         | `false`     |     `no`     |
 | `reset_values`               | When upgrading, reset the values to the ones built into the chart.                                                                                                                                                          | `bool`         | `false`     |     `no`     |
 | `force_update`               | Force resource update through delete/recreate if needed.                                                                                                                                                                    | `bool`         | `false`     |     `no`     |
 | `cleanup_on_fail`            | Allow deletion of new resources created in this upgrade when upgrade fails.                                                                                                                                                 | `bool`         | `false`     |     `no`     |
 | `disable_openapi_validation` | If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema.                                                                                                                | `bool`         | `false`     |     `no`     |
 | `max_history`                | Maximum number of release versions stored per release.                                                                                                                                                                      | `number`       | `0`         |     `no`     |
 | `wait`                       | Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as `timeout` .                                                                                        | `bool`         | `true`      |     `no`     |
 | `dependency_update`          | Runs helm dependency update before installing the chart.                                                                                                                                                                    | `bool`         | `false`     |     `no`     |
 | `timeout`                    | Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks).                                                                                                                                      | `number`       | `900`       |     `no`     |
 | `wait_for_jobs`              | If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`.                                                                           | `bool`         | `false`     |     `no`     |
 | `lint`                       | Run the helm chart linter during the plan.                                                                                                                                                                                  | `bool`         | `false`     |     `no`     |
 | `internet_enabled`           | Expose myelastic4hpcclogs-kibana service to the internet. This can cause the service to hang on pending state if external IPs are blocked by your organization's cloud policies.                                            | `bool`         | `true`      |     `no`     |
<br>

## Outputs
| **Name**         | **Description**                                                                  |
| :--------------- | :------------------------------------------------------------------------------- |
| `logaccess_body` | The HPCC log analytics yaml values to pass to the HPCC Platform helm deployment. |


