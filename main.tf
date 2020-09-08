locals {
  account_tier             = (var.account_kind == "FileStorage" ? "Premium" : split("_", var.sku)[0])
  account_replication_type = (local.account_tier == "Premium" ? "LRS" : split("_", var.sku)[1])
  resource_group_name = element(
  coalescelist(azurerm_resource_group.rg.*.name, [var.resource_group_name]), 0)
  location = element(
  coalescelist(azurerm_resource_group.rg.*.location, [var.location]), 0)
  if_static_website_enabled = var.enable_static_website ? [{}] : []
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}

resource "azurerm_storage_account" "storeacc" {
  name                      = var.storage_account_name
  resource_group_name       = local.resource_group_name
  location                  = local.location
  account_kind              = var.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic
  tags                      = merge({ "Name" = format("%s", var.storage_account_name) }, var.tags, )

  dynamic "static_website" {
    for_each = local.if_static_website_enabled
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }
}

# Following resource is not removed when we update the terraform plan with `false` after initial run. Need to check for the option to remove `$web` folder if we disable static website and update the plan. 
resource "null_resource" "copyfilesweb" {
  count = var.enable_static_website ? 1 : 0
  provisioner "local-exec" {
    command = "az storage blob upload-batch --no-progress --account-name ${azurerm_storage_account.storeacc.name} -s ${var.static_website_source_folder} -d '$web' --output none"
  }
}

resource "azurerm_cdn_profile" "cdn-profile" {
  count               = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  name                = var.cdn_profile_name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.cdn_sku_profile
  tags                = merge({ "Name" = format("%s", var.cdn_profile_name) }, var.tags, )
}

resource "random_string" "unique" {
  count   = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_cdn_endpoint" "cdn-endpoint" {
  count               = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  name                = random_string.unique.0.result
  profile_name        = azurerm_cdn_profile.cdn-profile.0.name
  location            = local.location
  resource_group_name = local.resource_group_name
  origin_host_header  = azurerm_storage_account.storeacc.primary_web_host
  # querystring_caching_behaviour = "IgnoreQueryString"

  origin {
    name      = "websiteorginaccount"
    host_name = azurerm_storage_account.storeacc.primary_web_host
  }

  # url_rewrite_action {
  #   source_pattern = "/.*"
  #   destination    = "/index.html"
  # }

}

