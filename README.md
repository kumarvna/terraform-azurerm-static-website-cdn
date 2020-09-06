# Azure Static website with CDN Endpoint Terraform Module

Terraform Module to create an Azure storage account and enable the static website also creates optional CDN service for the static website.

To change the storage account kind, set the argument `account_kind` to the appropriate value. By default, account kind set to `StorageV2`.  If the storage account kind set to other types, this module automatically computes the appropriate values for `account_tier` and `account_replication_type` arguments. The valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`.

> Note: *Static Website can only be created when the `account_kind` is set to `StorageV2`.*

These types of resources are supported

* [Storage Account](https://www.terraform.io/docs/providers/azurerm/r/storage_account.html)
* [Static Website](https://www.terraform.io/docs/providers/azurerm/r/storage_account.html#static_website)
* [Content Delivery Network (CDN)](https://www.terraform.io/docs/providers/azurerm/r/cdn_endpoint.html)

## Module Usage

```hcl
module "static-website-cdn" {
  source  = "kumarvna/static-website-cdn/azurerm"
  version = "2.0.0"

  # Resource Group, location, and Storage account details
  resource_group_name  = "rg-demo-westeurope-01"
  location             = "westeurope"
  storage_account_name = "storageaccwesteupore01"

  # Static Website createion requirements
  # account_kind should set to StorageV2 or BlockBlobStorage
  enable_static_website        = true
  static_website_source_folder = var.static_website_source_folder

  # CDN endpoint for satic website
  enable_cdn_profile = true
  cdn_profile_name   = var.cdn_profile_name
  cdn_sku_profile    = var.cdn_sku_profile

  # Adding TAG's to your Azure resources (Required)
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
```

## Create resource group

By default, this module will not create a resource group and the name of an existing resource group to be given in an argument `resource_group_name`. If you want to create a new resource group, set the argument `create_resource_group = true`.

>*If you are using an existing resource group, then this module uses the same resource group location to create all resources in this module.*

## Static Website

Azure Storage can serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container named $web. By default, this module enables the creation of a static website. To upload the static website content, set the folder path using argument `static_website_source_folder`.

## CDN Endpoint for Static Website

To add content delivery network acceleration to the static website, set the argument `enable_cdn_profile = true` and also provide appropriate values to the  `cdn_profile_name` and `cdn_sku_profile` arguments.

## Recommended naming and tagging conventions

Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and show back accounting mechanisms.

> ### Resource naming

An effective naming convention assembles resource names by using important resource information as parts of a resource's name. For example, using these [recommended naming conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging#example-names), a public IP resource for a production SharePoint workload is named like this: `pip-sharepoint-prod-westus-001`.

> ### Metadata tags

When applying metadata tags to the cloud resources, you can include information about those assets that couldn't be included in the resource name. You can use that information to perform more sophisticated filtering and reporting on resources. This information can be used by IT or business teams to find resources or generate reports about resource usage and billing.

The following list provides the recommended common tags that capture important context and information about resources. Use this list as a starting point to establish your tagging conventions.

Tag Name|Description|Key|Example Value|Required?
--------|-----------|---|-------------|---------|
Project Name|Name of the Project for the infra is created. This is mandatory to create a resource names.|ProjectName|{Project name}|Yes
Application Name|Name of the application, service, or workload the resource is associated with.|ApplicationName|{app name}|Yes
Approver|Name Person responsible for approving costs related to this resource.|Approver|{email}|Yes
Business Unit|Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this may represent a single corporate or shared top-level organizational element.|BusinessUnit|FINANCE, MARKETING,{Product Name},CORP,SHARED|Yes
Cost Center|Accounting cost center associated with this resource.|CostCenter|{number}|Yes
Disaster Recovery|Business criticality of this application, workload, or service.|DR|Mission Critical, Critical, Essential|Yes
Environment|Deployment environment of this application, workload, or service.|Env|Prod, Dev, QA, Stage, Test|Yes
Owner Name|Owner of the application, workload, or service.|Owner|{email}|Yes
Requester Name|User that requested the creation of this application.|Requestor| {email}|Yes
Service Class|Service Level Agreement level of this application, workload, or service.|ServiceClass|Dev, Bronze, Silver, Gold|Yes
Start Date of the project|Date when this application, workload, or service was first deployed.|StartDate|{date}|No
End Date of the Project|Date when this application, workload, or service is planned to be retired.|EndDate|{date}|No

> This module allows you to manage the above metadata tags directly or as a variable using `variables.tf`. All Azure resources which support tagging can be tagged by specifying key-values in argument `tags`. Tag `ResourceName` is added automatically to all resources.

```hcl
module "static-website-cdn" {
  source  = "kumarvna/static-website-cdn/azurerm"
  version = "2.0.0"

  # ... omitted

  tags = {
    ProjectName  = "demo-project"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}  
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | ~> 2.23 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.23 |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
`create_resource_group` | Whether to create resource group and use it for all networking resources | `string` | `false`
`resource_group_name` |The name of the resource group in which resources are created| `string` | `""`
`location` | The location of the resource group in which resources are created | `string` | `""`
`storage_account_name` | The name of the storage account to be created | `string` | `""`
`account_kind` | The kind of storage account | `string` | `"StorageV2"`
`sku` | The SKU of the storage account| `string` | `"Standard_GRS"`
`access_tier` | The access tier of the storage account| `string` | `"Hot"`
`enable_https_traffic` | Configure the storage account to accept requests from secure connections only. Possible values are `true` or `false`| `string` | `true`
`enable_static_website`|Controls if static website to be enabled on the storage account. Possible values are `true` or `false`| `string` | `false`
`static_website_source_folder` | Set a source folder path to copy static website files to static website storage blob | `string` | `""`
`assign_identity` |Specifies the identity type of the Storage Account| `string` | `true`
`enable_cdn_profile` | Controls the creation of CDN profile and endpoint for static website | `string` | `false`
`cdn_profile_name` | Specifies the name of the CDN Profile | `string` | `""`
`cdn_sku_profile` | The pricing related information of current CDN profile. Accepted values are `Standard_Akamai`, `Standard_ChinaCdn`, `Standard_Microsoft`, `Standard_Verizon` or `Premium_Verizon`. | `string` | `"Standard_Akamai"`
`custom_404_path` | path from your repo root to your custom 404 page | `string` | `"404.html"` | no |
`index_path` | path from your repo root to index.html | `string` | `"index.html"`
`tags` | A map of tags to add to all resources | `map(string)` | `{}`

## Outputs

| Name | Description |
|------|-------------|
`static_website_cdn_endpoint_hostname` | CDN endpoint URL for Static website
`static_website_cdn_profile_name` | CDN profile name for the static website
`static_website_url` | static web site URL from storage account
`storage_account_id` | The ID of the storage account
`storage_account_name` | The name of the storage account
`storage_primary_access_key` | The primary access key for the storage account
`storage_primary_connection_string` | The primary connection string for the storage account

## Authors

Module is maintained by [Kumaraswamy Vithanala](mailto:kumarvna@gmail.com) with the help from other awesome contributors.

## Other resources

* [Azure Storage documentation](https://docs.microsoft.com/en-us/azure/storage/)

* [Terraform AzureRM Provider Documentation](https://www.terraform.io/docs/providers/azurerm/index.html)
