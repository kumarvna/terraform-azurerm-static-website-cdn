# Azure Static website with CDN Endpoint

Terraform Module to create an Azure storage account and enable the static website and create optional CDN service for the static website.

You can configure your storage account to accept requests from secure connections only by setting the `enable_https_traffic_only = true` for the storage account. By default, this property is enabled when you create a storage account using this module.

To defines the kind of account, set the argument to `account_kind = "StorageV2"`. Account kind defaults to `StorageV2`. If you want to change this value to other storage accounts kind, then this module automatically computes the appropriate values for `account_tier`, `account_replication_type`. The valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`.

Note: *static_website can only be created when the account_kind is set to StorageV2.*

## These types of resources are supported

* [Storage Account](https://www.terraform.io/docs/providers/azurerm/r/storage_account.html)
* [Static Website](https://www.terraform.io/docs/providers/azurerm/r/storage_account.html#static_website)
* [Content Delivery Network (CDN)](https://www.terraform.io/docs/providers/azurerm/r/cdn_endpoint.html)

## Module Usage

Following example to create a storage account and set up a static website with CDN endpoint.

```hcl
module "static-website-cdn" {
  source                  = "kumarvna/static-website-cdn/azurerm"
  version                 = "1.0.0"
  
  # Resource Group
  create_resource_group   = false
  resource_group_name     = "rg-demo-westeurope-01"
  location                = "westeurope"
  storage_account_name    = "storageaccwesteupore01"

  # Static Website options
  enable_static_website   = true
  static_website_source_folder = var.static_website_source_folder

  # CDN endpoint for satic website
  enable_cdn_profile      = true
  cdn_profile_name        = var.cdn_profile_name
  cdn_sku_profile         = var.cdn_sku_profile
  
  # Tags for Azure resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
```

## Create resource group

By default, this module will not create a resource group and the name of an existing resource group to be given in an argument `resource_group_name`. If you want to create a new resource group, set the argument `create_resource_group = true`.

*If you are using an existing resource group, then this module uses the same resource group location to create all resources in this module.*

## Static Website

Azure Storage can serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container named $web.  To learn more, see [Static website hosting in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website).

Set the argument `enable_static_website = true` and set the folder path for static content to
  `static_website_source_folder = "../artifacts/website"`.

## CDN Endpoint for Static Website

To add content delivery network acceleration to you static website set the argument `enable_cdn_profile = true` and set the  `cdn_profile_name` and `cdn_sku_profile` as an variables.

## `sensitive` — Suppressing Values in CLI Output

An output can be marked as containing sensitive material using the optional `sensitive = true` argument in the output declration.

Setting an output value in the root module as sensitive prevents Terraform from showing its value in the list of outputs at the end of `terraform apply`. It might still be shown in the CLI output for other reasons, like if the value is referenced in an expression for a resource argument.

Sensitive output values are still recorded in the [state](https://www.terraform.io/docs/state/index.html), and so will be visible to anyone who is able to access the state data. Storing state remotely can provide better security. For more information, see [Sensitive Data in State.](https://www.terraform.io/docs/state/sensitive-data.html)

## Tagging

Use tags to organize your Azure resources and management hierarchy. You can apply tags to your Azure resources, resource groups, and subscriptions to logically organize them into a taxonomy. Each tag consists of a name and a value pair. For example, you can apply the name "Environment" and the value "Production" to all the resources in production. You can manage these values variables directly or mapping as a variable using `variables.tf`.

All Azure resources which support tagging can be tagged by specifying key-values in argument `tags`. Tag Name is added automatically on all resources. For example, you can specify `tags` like this:

```hcl
module "static-website-cdn" {
  source        = "kumarvna/static-website-cdn/azurerm"
  version       = "1.0.0"
  # ... omitted

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_tier | The access tier of the storage account. | `string` | `"Hot"` | no |
| account\_kind | The kind of storage account. | `string` | `"StorageV2"` | no |
| allowed\_headers | A list of headers that are allowed to be a part of the cross-origin request. | `list(string)` | `[]` | no |
| allowed\_methods | A list of http headers that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`. | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| allowed\_origins | A list of origin domains that will be allowed by CORS. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| assign\_identity | Set to `true` to enable system-assigned managed identity, or `false` to disable it. | `bool` | `true` | no |
| cdn\_profile\_name | Specify the cdn profile name | `string` | `"StaticCdnProfile"` | no |
| cdn\_sku\_profile | The pricing related information of current CDN profile. Accepted values are 'Standard\_Akamai', 'Standard\_ChinaCdn', 'Standard\_Microsoft', 'Standard\_Verizon' or 'Premium\_Verizon'. | `string` | `"Standard_Akamai"` | no |
| create\_resource\_group | Whether to create resource group and use it for all networking resources | `bool` | `false` | no |
| custom\_404\_path | path from your repo root to your custom 404 page | `string` | `"404.html"` | no |
| custom\_domain\_name | The custom domain name to use for your website | `string` | `""` | no |
| enable\_cdn\_profile | set to 'true' to enable the CDN profile and endpoint for static website | `bool` | `false` | no |
| enable\_https\_traffic | Set to `true` to allow HTTPS traffic, or `false` to disable it. | `bool` | `true` | no |
| enable\_static\_website | Set to `true` to enable static website or `false` to disable it | `bool` | `false` | no |
| exposed\_headers | A list of response headers that are exposed to CORS clients. | `list(string)` | `[]` | no |
| index\_path | path from your repo root to index.html | `string` | `"index.html"` | no |
| location | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `"westeurope"` | no |
| max\_age\_in\_seconds | The number of seconds the client should cache a preflight response.  Defaults to 2 days | `number` | `172800` | no |
| resource\_group\_name | A container that holds related resources for an Azure solution | `string` | `"rg-demo-westeurope-01"` | no |
| sku | The SKU of the storage account. | `string` | `"Standard_GRS"` | no |
| static\_website\_source\_folder | Set a source folder path to copy static website files to static website storage blob | `string` | `""` | no |
| storage\_account\_name | The name of the storage account to be created | `string` | `""` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| static\_website\_cdn\_endpoint\_hostname | CDN endpoint URL for Static website |
| static\_website\_cdn\_profile\_name | CDN profile name for the static website |
| static\_website\_url | static web site URL from storage account |
| storage\_account\_id | The ID of the storage account. |
| storage\_account\_name | The name of the storage account. |
| storage\_primary\_access\_key | The primary access key for the storage account. |
| storage\_primary\_connection\_string | The primary connection string for the storage account. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Resource Graph

![Resource Graph](graph.png)

## Authors

Module is maintained by [Kumaraswamy Vithanala](mailto:kumarvna@gmail.com) with the help from other awesome contributors.

## Other resources

* [Azure Storage documentation](https://docs.microsoft.com/en-us/azure/storage/)

* [Terraform AzureRM Provider Documentation](https://www.terraform.io/docs/providers/azurerm/index.html)
