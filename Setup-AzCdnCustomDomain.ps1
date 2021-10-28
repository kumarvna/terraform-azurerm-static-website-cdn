Import-Module Az.Cdn -Force
$cdnProfile = Get-AzCdnProfile -ProfileName $env:STATIC_CDN_PROFILE -ResourceGroupName $env:RG_NAME
$endpoint = Get-AzCdnEndpoint -ProfileName $cdnProfile.Name -ResourceGroupName $env:RG_NAME

$azCustomDomain = $null

# The friendly name of the custom domain in Azure Portal
$azCdnCustomDomainName = $env:FRIENDLY_NAME

try {
  Write-Host 'Checking for existing custom domain name...'
  $azCustomDomain = Get-AzCdnCustomDomain -CustomDomainName $azCdnCustomDomainName -CdnEndpoint $endpoint -ErrorAction stop
}
catch {
  try {
    Write-Host "Enabling custom domain $env:CUSTOM_DOMAIN..."
    $azCustomDomain = New-AzCdnCustomDomain -HostName $env:CUSTOM_DOMAIN -CdnEndpoint $endpoint -CustomDomainName $azCdnCustomDomainName -ErrorAction stop
    continue;
  }
  catch {
    Write-Error 'Could not create custom domain for CDN Endpoint'
    throw;
  }
}

if ($azCustomDomain.CustomHttpsProvisioningState -ne ('Enabled' -or 'Enabling')) {
  try {
    Write-Host "Enabling HTTPS for $env:CUSTOM_DOMAIN..."
    Enable-AzCdnCustomDomainHttps -ResourceId $azCustomDomain.Id -ErrorAction stop
  }
  catch {
    Write-Error "Error enabling HTTPS for $env:CUSTOM_DOMAIN..."
    throw;
  }
}


Write-Host "Success:  CDN configured for HTTPS at $env:CUSTOM_DOMAIN" -ForegroundColor Green