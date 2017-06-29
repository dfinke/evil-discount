param(
    [Parameter(Mandatory)]
    $ResourceGroupName,
    [Parameter(Mandatory)]
    $functionName,
    [Parameter(Mandatory)]
    $repoUrl,
    $Location = "eastus"
)

try {
    $ctx = Get-AzureRmContext
    if (!$ctx.Subscription) {
        $null = Login-AzureRmAccount
    }
}
catch {
    $null = Login-AzureRmAccount     
}

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location -Force

$hashtable = @{
    siteName     = $functionName
    siteLocation = $Location
    repoUrl      = $repoUrl
}

New-AzureRmResourceGroupDeployment `
    -TemplateFile .\deploy.json `
    -ResourceGroupName $ResourceGroupName `
    -TemplateParameterObject $hashtable `
    -Verbose