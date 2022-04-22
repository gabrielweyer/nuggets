# Azure resources naming conventions

It's important to establish a naming conventions upfront as some resources can't be renamed easily. Keep in mind that storage accounts, Key Vaults... have a restrictive max length so you'll need to strike a balance between meaningful names and brevity. Tags play a key role in grouping resources.

Use **all lower case** names and follow a pattern inspired by `{projectname}-{servicename}-{resourcetype}-{environment}`. The two most important information are the system this resource belongs to and the environment. This is why they're at the beginning and the end of the name.

| Section      | Description |
| ------------ | ----------- |
| projectname  | The project name does not contain dashes so that dashes are only used to separate resource name sections. Try to stick with what a project does rather than a name code (projects get renamed). |
| servicename  | `api`, `processor`. The service name does not contain dashes so that dashes are only used to separate resource name sections. |
| resourcetype | `alert` (Metrics alert), `app` (Web App), `appi` (Application Insights), `cosmos` (Cosmos DB), `adf` (Azure Data Factory), `func` (Function), `kv` (KeyVault), `log` (Log Analytics Workspace), `plan` (App Service plan), `policy` (Policy), `rg` (Resource Group), `sb` (Service Bus), `sql` (SQL Server). See [Azure recommended resource-type prefixes][recommended-abbreviations-for-azure-resource-types]. |
| Environment  | `dev` / `d` (development environment), `uat` / `u` (UAT environment), `prod` / `p` (production environment). Adapt to match your own environments. |

## Tags

Use consistent tags on all resources.

- Domain: related to `projectname`, the system this resource belongs to
- Environment: `DEV`, `UAT` or `PROD`. Can consider a `NONPROD` for resources shared by development and UAT
- Owner: an email address so that people can find who owns a system

## ARM template

Follow [ARM template best practices][arm-template-best-practices].

## Storage account and Key Vault

Storage accounts need to be globally unique, are limited to 24 characters and only support alphanumeric characters (no hyphens allowed). Key Vault suffers from a similar issue with the exception that hyphens are allowed.

I’ve been experiencing with using a one letter abbreviation for the environment:

- `d`: Development
- `u`: UAT
- `p`: Production

I use the number `7` to separate the different sections:

- `checkout7api7p`
- `checkout7api7d`

The main issue with this convention is that using `7` as a separator is unexpected. I'm keen on coming up with a better convention.

## Service Bus

Queues and topics are only referred to in the context of a Service Bus namespace. Hence adding the environment is redundant. Instead I have been using a suffix to differentiate queues and topics:

- `chicken-topic`
- `dog-queue`

## Monitor alert

Alerts are defined at a specific scope (an Application Insights resource, a Service Bus namespace…). You only need to be able to differentiate them within a single system.

- `elevated-checkout-errors`

Alerts are also displayed in the Azure Portal [Monitor > Alerts][azure-portal-alerts] but they can be filtered by subscription and resources.

## Autoscale settings

Autoscale settings are only used in the context of an App Service plan. Hence adding the environment is redundant. The recommended name is `default-autoscalesettings`.

[recommended-abbreviations-for-azure-resource-types]: https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
[arm-template-best-practices]: https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/best-practices
[azure-portal-alerts]: https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/alertsV2
