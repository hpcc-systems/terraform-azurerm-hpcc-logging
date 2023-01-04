# terraform-azurerm-hpcc-logging
This module provides log solutions for the HPCC Platform.
<br/>
<br/>

## Requirements
<br/>

### This module requires a running Azure Kubernetes Service before deployment.
<br/>

### Appendix A

`azure_log_analytics_workspace` object specification

| **Variable**                 | **Description**                                                                            | **Type** | **Required**       | **Default**                   |
| :--------------------------- | :----------------------------------------------------------------------------------------- | :------- | :----------------- | :---------------------------- |
| `unique_name`                | Should a the azure log analytics workspace have a unique?                                  | `bool`   | `no`               | `true`                        |
| `name`                       | Azure log analytics workspace's name.                                                      | `string` | `no`               | `myhpccloganalyticsworkspace` |
| `resource_group_name`        | The name of the resource group to which the existing azure log analytics workspace belong. | `string` | `yes`              | -                             |
| `location`                   | Azure region in which to create resources.                                                 | `string` | `yes`              | `eastus2`                     |
| `daily_quota_gb`             | The daily data ingestion quota in GB.                                                      | `number` | `-1` for unlimited |
| `internet_ingestion_enabled` | Should the workspace support ingestion over the Public Internet?                           | `bool`   | `no`               | `false`                       | `false` |

 |`internet_query_enabled`             | Should the workspace support querying over the Public Internet?                                                                                | `bool`           | `no`               | `false`                       |
| `reservation_capacity_in_gb_per_day` | The capacity reservation level in GB for the workspace. The value must be increments of 100 between 100 and 5000.                              | `number`         | `no`               | `100`                         |
| `retention_in_days`                  | The workspace data daily retention. The value should be 7 for free tier or between 30 and 730.                                                 | `number`         | `no`               | `30`                          |
| `sku`                                | The SKU of the workspace. Possible values are `Free`,`PerNode`,`Premium`,`Standard`,`Standalone`,`Unlimited`,`CapacityReservation`,`PerGB2018` | `string`         | `no`               | `PerGB2018`                   |
| `tag`                                | Tags to be added to the workspace.                                                                                                             | `map(string)`    | `no`               | -                             |
| `use_existing_workspace`             | The existing workspace to use. Both `name` and `resource_group_name` attributes must be set.                                                   | `object(string)` | `no`               | -                             |

### Appendix B
`azure_log_analytics_workspace.use_existing_workspace` object specification

| **Variable**          | **Description**                                                                            | **Type** | **Required** |
| :-------------------- | :----------------------------------------------------------------------------------------- | :------- | :----------- |
| `name`                | The name of the existing azure log analytics workspace to use.                             | `string` | `yes`        |
| `resource_group_name` | The name of the resource group to which the existing azure log analytics workspace belong. | `string` | `yes`        |

### Appendix C

`azure_log_analytics_creds` object specification

| **Variable**        | **Description**                                    | **Type** | **Required** |
| :------------------ | :------------------------------------------------- | :------- | :----------- |
| `AAD_TENANT_ID`     | Azure Active Directory/Service Principal tenant ID | `string` | `yes`        |
| `AAD_CLIENT_ID`     | Azure Active Directory/Service Principal client ID | `string` | `yes`        |
| `AAD_CLIENT_SECRET` | Azure Active Directory/Service Principal secret    | `string` | `yes`        |
| `AAD_PRINCIPAL_ID`  | Service Principal ID                               | `string` | `yes`        |

### Appendix D

`hpcc` object specification

| **Variable** | **Description**            | **Type** | **Default** | **Required** |
| :----------- | :------------------------- | :------- | :---------- | :----------- |
| `namespace`  | Namespace name.            | `string` | `hpcc`      | `yes`        |
| `version`    | The HPCC Platform version. | `string` | `8.10.10`   | `yes`        |

