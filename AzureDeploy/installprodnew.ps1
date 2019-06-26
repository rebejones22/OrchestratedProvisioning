# Provision storage and function app
 $script2=Invoke-WebRequest https://raw.githubusercontent.com/rebejones22/OrchestratedProvisioning/master/AzureDeploy/Deploy-AzureResourceGroup.ps1 
 Invoke-Expression $($script2.Content) 
    -ResourceGroupLocation CentralUS `
    -ResourceGroupName OrchestratedProvisioningProd `
    -TemplateParametersFile prod.parameters.json

# Ensure storage queues are in place
$storageAccount = Get-AzureRmStorageAccount | Where-Object ResourceGroupName -eq "OrchestratedProvisioningProd"
$storageContext = $storageAccount.Context
New-AzureStorageQueue -Name "create-team-request-queue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "create-team-completion-queue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-request-queue" -Context $storageContext -ErrorAction Ignore
New-AzureStorageQueue -Name "clone-team-completion-queue" -Context $storageContext -ErrorAction Ignore



