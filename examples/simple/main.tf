module "static-website-cdn" {
  source  = "kumarvna/static-website-cdn/azurerm"
  version = "2.2.0"

  # Resource Group, location, and Storage account details
  resource_group_name  = "rg-demo-westeurope-01"
  location             = "westeurope"
  storage_account_name = "storageaccwesteupore01"

  # Static Website creation set to true by default
  # account_kind should set to StorageV2 or BlockBlobStorage
  static_website_source_folder = var.static_website_source_folder
  index_path                   = var.index_path
  custom_404_path              = var.custom_404_path

  # Adding TAG's to your Azure resources (Required)
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
