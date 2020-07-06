# Azure Static website with CDN Endpoint

Configuration in this directory creates Azure storage account and enable the static website and create optional CDN service for the static website. Few of these resources added/excluded as per your requirement.

## Module Usage

## Static Website

Following example to create a storage account with static website.

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
  
  # Tags for Azure resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
```

## Static Website with CDN endpoint

Following example to create a storage account, static website with CDN endpoint.

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

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.

## Outputs

Name | Description
---- | -----------
`resource_group_name` | The name of the resource group in which resources are created
`resource_group_id` | The id of the resource group in which resources are created
`resource_group_location`| The location of the resource group in which resources are created
`storage_account_id` | The ID of the storage account
`sorage_account_name`| The name of the storage account
`storage_primary_connection_string`|The primary connection string for the storage account
`storage_primary_access_key`|The primary access key for the storage account
`static_website_url`|Static web site URL from storage account
`static_website_cdn_profile_name`|Name of the CDN profile
`static_website_cdn_endpoint_url`| CDN URL for static website
