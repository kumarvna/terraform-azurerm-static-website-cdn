output "storage_account_id" {
  value       = module.staticweb.storage_account_id
  description = "The ID of the storage account."
}

output "sorage_account_name" {
  value       = module.staticweb.sorage_account_name
  description = "The name of the storage account."
}

output "storage_primary_connection_string" {
  value       = module.staticweb.storage_primary_connection_string
  sensitive   = true
  description = "The primary connection string for the storage account."
}

output "storage_primary_access_key" {
  value       = module.staticweb.storage_primary_access_key
  sensitive   = true
  description = "The primary access key for the storage account."
}

output "static_website_url" {
  value = module.staticweb.static_website_url
  description = "static web site URL from storage account"
}