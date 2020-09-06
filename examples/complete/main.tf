module "static-website-cdn" {
  source  = "kumarvna/static-website-cdn/azurerm"
  version = "2.0.0"

  # Resource Group, location, and Storage account details
  create_resource_group = true
  resource_group_name   = "rg-demo-westeurope-01"
  location              = "westeurope"
  storage_account_name  = "storageaccwesteupore01"

  # Static Website createion set to true by default
  # account_kind should set to StorageV2 or BlockBlobStorage
  static_website_source_folder = var.static_website_source_folder
  index_path                   = var.index_path
  custom_404_path              = var.custom_404_path

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
