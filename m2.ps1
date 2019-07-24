param(
    [string] [Parameter(Mandatory = $true)] $Name
)

. "$PSScriptRoot\Common.ps1"

$ResourceGroupName = "RK-$Name"
$Location = "centralus"
$KeyVaultName = "KV-$Name"

CheckedLoggedIn

EnsureResourceGroup $ResourceGroupName $Location

$keyVault = EnsureKeyVault $KeyVaultName $ResourceGroupName $Location
