variable "storage_account_name" {
  default = "storageaccwesteupore01"
}

variable "static_website_source_folder" {
  default = "../artifacts/imagine"
}

variable "cdn_profile_name" {
  default = "mycdnprofile-westeurope-01"
}

variable "cdn_sku_profile" {
  default = "Standard_Microsoft"
}

variable "index_path" {
  description = "path from your repo root to index.html"
  default     = "index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  default     = "404.html"
}
