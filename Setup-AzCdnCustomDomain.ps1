Import-Module Az.Cdn -Force
$cdnProfile = Get-AzCdnProfile -ProfileName $env:STATIC_CDN_PROFILE -ResourceGroupName $env:RG_NAME
$endpoint = Get-AzCdnEndpoint -ProfileName $cdnProfile.Name -ResourceGroupName $env:RG_NAME

$azCustomDomain = $null

# The friendly name of the custom domain in Azure Portal
$azCdnCustomDomainName = $env:FRIENDLY_NAME

try {
  Write-Host 'Checking for existing custom domain name...'
  $azCustomDomain = Get-AzCdnCustomDomain -CustomDomainName $azCdnCustomDomainName -EndpointName $endpoint.Name -ProfileName $cdnProfile.Name -ResourceGroupName $env:RG_NAME -ErrorAction stop
}
catch {
  try {
        $dn=$($env:CUSTOM_DOMAIN) -Split "\."
    Write-Warning "At this point, you should have made a CNAME record like '$($dn[0..($dn.Count-3)]) IN CNAME $($endpoint.HostName).' Things WILL fail if you did not do that. In that case, please make this record, then relaunch me."
    Write-Host "Enabling custom domain $env:CUSTOM_DOMAIN..."
    $azCustomDomain = New-AzCdnCustomDomain -HostName $env:CUSTOM_DOMAIN -EndpointName $endpoint.Name -CustomDomainName $azCdnCustomDomainName -ProfileName $cdnProfile.Name -ResourceGroupName $env:RG_NAME -ErrorAction stop
    continue;
  }
  catch {
    Write-Error 'Could not create custom domain for CDN Endpoint'
    throw;
  }
}

if ($azCustomDomain.CustomHttpsProvisioningState -ne 'Enabled' -and $azCustomDomain.CustomHttpsProvisioningState -ne 'Enabling') {
  try {
    Write-Host "Enabling HTTPS for $env:CUSTOM_DOMAIN..."
    # -ProtocolType should be either ServerNameIndication or IPBased
    # I really don't know what's the difference...
    $azCustomDomainHttpsParameters = New-AzCdnManagedHttpsParametersObject -CertificateSourceParameterCertificateType Dedicated -CertificateSource Cdn  -ProtocolType ServerNameIndication
    $azCustomDomainHttps = Enable-AzCdnCustomDomainCustomHttps -ProfileName $cdnProfile.Name -EndpointName $endpoint.Name -CustomDomainName $azCdnCustomDomainName -CustomDomainHttpsParameter $azCustomDomainHttpsParameters -ResourceGroupName $env:RG_NAME -ErrorAction stop
    Write-Host -Foreground Green "HTTPS enabled for $($env:CUSTOM_DOMAIN). Process can be quite long to terminate (minutes to sometimes hours). Check the Azure page of your custom domain."
  }
  catch {
    Write-Error "Error enabling HTTPS for $($env:CUSTOM_DOMAIN)..."
    throw;
  }
} else {
  Write-Warning "Azure is already beeing configuring HTTPS for your custom domain $($env:CUSTOM_DOMAIN)"
}
