This is a automation tool for creating , delete and update resource group on azure

## Pre-requirement
1. need to install azure cli, ref: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
2. run
```powershell
    az login
```
if you are using azure china, please use this command
```powershell
    az login -e AzureChinaCloud
```
    
## How to use
1. git clone the script on your machine, and Set-ExecutionPolicy to Unrestricted otherwise can run the scripts
2. create a json file which is config for telling the tool how to create your defined resource group
3. the json file can use resourcegroup.json as reference.
4. To run the tool you can, cd to this directory and simply run this
```powershell
    .\resourcegroup.ps1 up
```
This command will read the default .\resourcegroup.json config and create the resource group will all related resource i.e network,security group, peering..etc
```powershell
    .\resourcegroup.ps1 up --configfile "AutomationTesting.json"
```
This command will read your defined .\AutomationTesting.json to create the resource group
```powershell
    .\resourcegroup.ps1 down
```
This command will ask you do you want to remove the resourcegroup , if you said yes, the resource group will be remove.
```powershell
    .\resourcegroup.ps1 update
```
This command is to update resource greoup's resources, currently will update vnet, security group including update rule, subnet and peering. 
    
## Roadmap for update
1. enable auto login for az cli tool
2. separate config to another git repository, separate configuration and developement.
3. enhance update feature for focus update single resources.
