# Azure Static website with CDN Endpoint

Configuration in this directory creates Azure storage account and enable the static website and create optional CDN service for the static website.

## Module Usage

```hcl
module "static-website-cdn" {
  source  = "kumarvna/static-website-cdn/azurerm"
  version = "2.2.0"

  # Resource Group, location, and Storage account details
  create_resource_group = true
  resource_group_name   = "rg-demo-westeurope-01"
  location              = "westeurope"
  storage_account_name  = "storageaccwesteupore01"

  # Static Website creation set to true by default
  # account_kind should set to StorageV2 or BlockBlobStorage
  static_website_source_folder = var.static_website_source_folder
  index_path                   = var.index_path
  custom_404_path              = var.custom_404_path

  # CDN endpoint for static website
  enable_cdn_profile = true
  cdn_profile_name   = var.cdn_profile_name
  cdn_sku_profile    = var.cdn_sku_profile

  # Custom domain for CDN endpoint
  custom_domain_name = "web.example.com"
  friendly_name      = "mywebapp"

  # Adding TAG's to your Azure resources (Required)
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

| Name | Description |
|------|-------------|
| static\_website\_cdn\_endpoint\_hostname | CDN endpoint URL for Static website |
| static\_website\_cdn\_profile\_name | CDN profile name for the static website |
| static\_website\_url | static web site URL from storage account |
| storage\_account\_id | The ID of the storage account. |
| storage\_account\_name | The name of the storage account. |
| storage\_primary\_access\_key | The primary access key for the storage account. |
| storage\_primary\_connection\_string | The primary connection string for the storage account. |
