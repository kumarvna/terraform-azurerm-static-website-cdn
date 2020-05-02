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
  default = "Standard_Akamai" 
}