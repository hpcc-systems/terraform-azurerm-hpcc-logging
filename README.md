# terraform-azurerm-hpcc-logging
This module provides log solutions for the HPCC Platform.
<br/>
<br/>

## Requirements
* This module requires a running `Azure Kubernetes Service`. To avoid create a cycle, first, deploy your Azure Kubernetes Service cluster before attempting to deploy this module.
* An Azure Service Principal is needed for authentication when using the Azure Log Analytics Workspace. See the `azure_log_analytics_creds` arguments for more info.
<br/>

## Limitations
* Private connection is not yet supported. `internet_query_enabled` and `internet_ingestion_enabled` must be set to true.
* Only one log solution can be used at a time. That is intentional.
* The `HPCC` app and the this module must share the same `namespace` when using the `Azure Log Analytics Workspace`.
<br/>

## Supported Arguments
<br/>

## `azure_log_analytics_workspace` object specifications

| **Variable**                         | **Description**                                                                                                                                                                                                                                                                                | **Type**         | **Required** | **Default**                   |
| :----------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------- | :----------- | :---------------------------- |
| `unique_name`                        | Should a the Azure Log Analytics Workspace have a unique?                                                                                                                                                                                                                                      | `bool`           | `no`         | `true`                        |
| `name`                               | Azure Log Analytics Workspace's name.                                                                                                                                                                                                                                                          | `string`         | `yes`        | `myhpccloganalyticsworkspace` |
| `resource_group_name`                | The name of the resource group to which the existing Azure Log Analytics Workspace belong.                                                                                                                                                                                                     | `string`         | `yes`        | -                             |
| `location`                           | Azure region in which to create resources.                                                                                                                                                                                                                                                     | `string`         | `yes`        | `eastus2`                     |
| `daily_quota_gb`                     | The daily data ingestion quota in GB.                                                                                                                                                                                                                                                          | `number`         | `no`         | `-1` for unlimited            |
| `internet_ingestion_enabled`         | Should the workspace support ingestion over the Public Internet?                                                                                                                                                                                                                               | `bool`           | `no`         | `false`                       | `false` |
| `internet_query_enabled`             | Should the workspace support querying over the Public Internet?                                                                                                                                                                                                                                | `bool`           | `no`         | `false`                       |
| `reservation_capacity_in_gb_per_day` | The capacity reservation level in GB for the workspace. The value must be increments of 100 between 100 and 5000.                                                                                                                                                                              | `number`         | `no`         | `100`                         |
| `retention_in_days`                  | The workspace data daily retention. The value should be 7 for free tier or between 30 and 730.                                                                                                                                                                                                 | `number`         | `no`         | `30`                          |
| `sku`                                | The SKU of the workspace. Possible values are `Free`,`PerNode`,`Premium`,`Standard`,`Standalone`,`Unlimited`,`CapacityReservation`,`PerGB2018`                                                                                                                                                 | `string`         | `no`         | `PerGB2018`                   |
| `tag`                                | Tags to be added to the workspace.                                                                                                                                                                                                                                                             | `map(string)`    | `no`         | `null`                        |
| `use_existing_workspace`             | The existing workspace to use. Both `name` and `resource_group_name` attributes must be set.                                                                                                                                                                                                   | `object(string)` | `no`         | `null`                        |
| `linked_storage_account`             | The storage account to link to the Azure Log Analytics Workspace as described below. The storage account must be assigned as bypass for `AzureServices`. In addition, if using a private link, the subnet id of the private endpoint should be added to the allow list of the storage account. | `object`         | `no`         | `null`                        |
<br/>

## `azure_log_analytics_workspace.use_existing_workspace` object specifications

| **Variable**          | **Description**                                                                            | **Type** | **Required** |
| :-------------------- | :----------------------------------------------------------------------------------------- | :------- | :----------- |
| `name`                | The name of the existing Azure Log Analytics Workspace to use.                             | `string` | `yes`        |
| `resource_group_name` | The name of the resource group to which the existing Azure Log Analytics Workspace belong. | `string` | `yes`        |
<br/>

## `azure_log_analytics_workspace.linked_storage_account` object specifications

| **Variable**          | **Description**                                                                                                                                         | **Type**       | **Required** |
| :-------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------- | :----------- |
| `data_source_type`    | The data source type that to use for the Azure Log Analytics Workspace. Acceptable values are `CustomLogs`, `AzureWatson`, `Query`,`Ingestion`, `Alert` | `string`       | `yes`        |
| `storage_account_ids` | The storage account resource IDs to be linked.                                                                                                          | `list(string)` | `yes`        |
<br/>

## `azure_log_analytics_creds` object specifications

| **Variable**        | **Description**                                    | **Type** | **Required** |
| :------------------ | :------------------------------------------------- | :------- | :----------- |
| `AAD_TENANT_ID`     | Azure Active Directory/Service Principal tenant ID | `string` | `yes`        |
| `AAD_CLIENT_ID`     | Azure Active Directory/Service Principal client ID | `string` | `yes`        |
| `AAD_CLIENT_SECRET` | Azure Active Directory/Service Principal secret    | `string` | `yes`        |
| `AAD_PRINCIPAL_ID`  | Service Principal ID                               | `string` | `yes`        |
<br/>

## `hpcc` object specifications

| **Variable** | **Description**                                                                        | **Type** | **Default** | **Required** |
| :----------- | :------------------------------------------------------------------------------------- | :------- | :---------- | :----------- |
| `namespace`  | Namespace name. This must be the namespace where HPCC Platform is or will be deployed. | `string` | -           | `yes`        |
| `version`    | The HPCC Platform version.                                                             | `string` | -           | `yes`        |
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

## `subnet_id` specifications

| **Variable** | **Description**                                                         | **Type** | **Default** | **Required** |
| :----------- | :---------------------------------------------------------------------- | :------- | :---------- | :----------- |
| `subnet_id`  | The subnet ID from which to allocate IPs for the Azure private endpoint | `string` | `null`      | `no`         |
<br/>

## Outputs
| **Name**                | **Description**                                                                                                        |
| :---------------------- | :--------------------------------------------------------------------------------------------------------------------- |
| `logaccess_body`        | The HPCC log analytics or elastic4hpcclogs yaml values to pass to the HPCC Platform helm deployment.                   |
| `workspace_resource_id` | The resource ID of the analytics workspace ID.                                                                         |
| `workspace_id`          | The ID of the analytics workspace ID to assign to the AKS cluster. Valid format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. |
| `primary_shared_key`    | The Azure Log Analytics Workspace primary shared key.                                                                  |
| `secondary_shared_key`  | The Azure Log Analytics Workspace secondary shared key.                                                                |



