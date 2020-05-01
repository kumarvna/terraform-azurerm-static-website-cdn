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

variable "application_name" {
    description = "Please provide your application name"
    default     = ""
}

variable "owner_email" {
    description = "Please provide owner email for this environment"
    default     = ""
}

variable "business_unit" {
    description = "Please provide Business Unit details here"
    default     = ""
}

variable "costcenter_id" {
    description = "Plesae provide cost center Id here"
    default     = ""
}
variable "environment" {
    description = "Please provide your application environment details here"
    default     = ""
}
