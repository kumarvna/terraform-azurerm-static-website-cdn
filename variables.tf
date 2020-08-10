variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = "rg-demo-westeurope-01"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "westeurope"
}

variable "storage_account_name" {
  description = "The name of the storage account to be created"
  default     = ""
}

variable "account_kind" {
  default     = "StorageV2"
  description = "The kind of storage account."
}

variable "sku" {
  default     = "Standard_GRS"
  description = "The SKU of the storage account."
}

variable "access_tier" {
  default     = "Hot"
  description = "The access tier of the storage account."
}

variable "enable_https_traffic" {
  default     = true
  description = "Set to `true` to allow HTTPS traffic, or `false` to disable it."
}

variable "enable_static_website" {
  default     = false
  description = "Set to `true` to enable static website or `false` to disable it"
}

variable "static_website_source_folder" {
  default     = ""
  description = "Set a source folder path to copy static website files to static website storage blob"
}

variable "assign_identity" {
  default     = true
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
}

variable "enable_cdn_profile" {
  default     = false
  description = " set to 'true' to enable the CDN profile and endpoint for static website"
}

variable "cdn_profile_name" {
  description = "Specify the cdn profile name"
  default     = "StaticCdnProfile"
}

variable "cdn_sku_profile" {
  default     = "Standard_Akamai"
  description = "The pricing related information of current CDN profile. Accepted values are 'Standard_Akamai', 'Standard_ChinaCdn', 'Standard_Microsoft', 'Standard_Verizon' or 'Premium_Verizon'."
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "index_path" {
  type        = string
  description = "path from your repo root to index.html"
  default     = "index.html"
}

# variable "custom_404_path" {
#   type        = string
#   description = "path from your repo root to your custom 404 page"
#   default     = "public/404.html"
# }
