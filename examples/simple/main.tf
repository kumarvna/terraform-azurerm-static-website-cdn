module "staticweb" {
  source                  = "github.com/kumarvna/terraform-azurerm-static-website-cdn?ref=v1.0.0"
  create_resource_group   = false
  resource_group_name     = "rg-demo-westeurope-01"
  location                = "westeurope"
  storage_account_name    = "storageaccwesteupore01"
  # Static Website options
  enable_static_website   = true
  static_website_source_folder = var.static_website_source_folder
  # Tags to map 
  tags = {
    application_name      = "demoapp01"
    owner_email           = "user@example.com"
    business_unit         = "publiccloud"
    costcenter_id         = "5847596"
    environment           = "development"
  }             
}