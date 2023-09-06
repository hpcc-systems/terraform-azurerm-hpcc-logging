# terraform-azurerm-hpcc-logging
This module provides Azure Log Analytics Workspace for the HPCC Platform.
<br/>
<br/>

## Requirements
This module requires a running Azure Kubernetes Service.
To avoid create a cycle, first, deploy your Azure Kubernetes Service cluster before attempting to deploy this module.
<br/>

## Limitations
* Private connection is not yet supported. `internet_query_enabled` and `internet_ingestion_enabled` must be set to true.
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
| `use_existing_role_assignment`       | Should an existing workspace be used? This will stop the module from creating a new role assignment.                                                                                                                                                                                           | `bool`           | `no`         | `false`                       |
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

## `subnet_id` specifications

| **Variable** | **Description**                                                         | **Type** | **Default** | **Required** |
| :----------- | :---------------------------------------------------------------------- | :------- | :---------- | :----------- |
| `subnet_id`  | The subnet ID from which to allocate IPs for the Azure private endpoint | `string` | `null`      | `no`         |
<br/>

## Outputs
| **Name**               | **Description**                                                                                                        |
| :--------------------- | :--------------------------------------------------------------------------------------------------------------------- |
| `logaccess_body`       | The HPCC log analytics yaml values to pass to the HPCC Platform helm deployment.                                       |
| `resource_id`          | The resource ID of the analytics workspace ID.                                                                         |
| `workspace_id`         | The ID of the analytics workspace ID to assign to the AKS cluster. Valid format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. |
| `primary_shared_key`   | The Azure Log Analytics Workspace primary shared key.                                                                  |
| `secondary_shared_key` | The Azure Log Analytics Workspace secondary shared key.                                                                |



