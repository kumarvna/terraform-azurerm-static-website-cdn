output "storage_account_id" {
  value       = module.static-website-cdn.storage_account_id
  description = "The ID of the storage account."
}

output "storage_account_name" {
  value       = module.static-website-cdn.storage_account_name
  description = "The name of the storage account."
}

output "storage_primary_connection_string" {
  value       = module.static-website-cdn.storage_primary_connection_string
  sensitive   = true
  description = "The primary connection string for the storage account."
}

output "storage_primary_access_key" {
  value       = module.static-website-cdn.storage_primary_access_key
  sensitive   = true
  description = "The primary access key for the storage account."
}

output "static_website_cdn_endpoint_hostname" {
  value       = module.static-website-cdn.static_website_cdn_endpoint_hostname
  description = "CDN endpoint URL for Static website"
}

output "static_website_cdn_profile_name" {
  value       = module.static-website-cdn.static_website_cdn_profile_name
  description = "CDN profile name for the static website"
}

output "static_website_url" {
  value       = module.static-website-cdn.static_website_url
  description = "static web site URL from storage account"
}
