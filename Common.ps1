$ErrorActionPreference = 'Stop'

function CheckedLoggedIn()
{
    $rmContext = Get-AzureRmContext

    if($null -eq $rmContext.Account) {
        Write-Host "You are not logged into Azure. Use Login-AzureRmAccount to log in first"
        exit
    }

    Write-Host "You are running as '$($rmContext.Account.Id)' in subscription '$($rmContext.Subscription.Name)'"

}

function EnsureResourceGroup([string] $Name, [string] $location) {
    #prepare Resource Group
    Write-Host "Checking if '$Name' exists..."
    $resourceGroup = Get-AzureRmResourceGroup -Name $Name -Location $location -ErrorAction Ignore
    if($null -eq $resourceGroup) 
    {
        Write-Host " resource group doesn't exist creating a new one..."
        $resourceGroup = New-AzureRmResourceGroup -Name $Name -Location $location
        Write-Host " resource group created."
    }
    else 
    {
        Write-Host " resource group already exists."
    }
}

function EnsureKeyVault([string]$Name, [string]$ResourceGroup, [string]$location) {
    Write-Host "Checking if Key Valut '$Name' exists..."
    $KeyVault = Get-AzureRmKeyVault -VaultName $Name -ErrorAction Ignore
    if($null -eq $KeyVault) {
        Write-Host "  key vault doesn't exist, creating a new one..."
        $KeyVault = New-AzureRmKeyVault -VaultName $Name -ResourceGroupName $ResourceGroup -Location $location -EnabledForDeployment
        Write-Host "  key vault created"
    } 
    else 
    {
        Write-Host " Key Vault already exists"
    }

    $KeyVault
}