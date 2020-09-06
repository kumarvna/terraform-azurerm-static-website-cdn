variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  default     = ""
}

variable "location" {
  description = "The location of the resource group in which resources are created"
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account to be created"
  default     = ""
}

variable "account_kind" {
  description = "The kind of storage account."
  default     = "StorageV2"
}

variable "sku" {
  description = "The SKU of the storage account."
  default     = "Standard_GRS"
}

variable "access_tier" {
  description = "The access tier of the storage account."
  default     = "Hot"
}

variable "enable_https_traffic" {
  description = "Configure the storage account to accept requests from secure connections only. Possible values are `true` or `false`"
  default     = true
}

variable "enable_static_website" {
  description = "Controls if static website to be enabled on the storage account. Possible values are `true` or `false`"
  default     = true
}

variable "static_website_source_folder" {
  description = "Set a source folder path to copy static website files to static website storage blob"
  default     = ""
}

variable "assign_identity" {
  description = "Specifies the identity type of the Storage Account. At this time the only allowed value is SystemAssigned."
  default     = true
}

variable "enable_cdn_profile" {
  description = "Controls the creation of CDN profile and endpoint for static website. Possible values are `true` or `false`"
  default     = false
}

variable "cdn_profile_name" {
  description = "Specifies the name of the CDN Profile"
  default     = ""
}

variable "cdn_sku_profile" {
  description = "The pricing related information of current CDN profile. Accepted values are 'Standard_Akamai', 'Standard_ChinaCdn', 'Standard_Microsoft', 'Standard_Verizon' or 'Premium_Verizon'."
  default     = "Standard_Akamai"
}

variable "index_path" {
  description = "path from your repo root to index.html"
  default     = "index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  default     = "404.html"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
