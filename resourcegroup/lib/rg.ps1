function rg-create-resourcegroup($_rgname,$_location="chinaeast2"){
    if($_rgname -eq $null){
        echo "resource group name cannot be empty"
        exit 1
    }
    echo "[Create] resourcegroup :$_rgname "
    az group create --name "$_rgname" --location "$_location"
    echo "[completed]"
}
function rg-delete-resourcegroup($_rgname){
    if($_rgname -eq $null){
        echo "resource group name cannot be empty"
        exit 1
    }
    echo "[Remove] Resource Group `"$resourceGroupName`" will be reomve..."
    az group delete -n "$_rgname"
    echo "[completed]"
}

function rg-get-config-json($_json_path){
   $resourceGroup= Get-Content "$_json_path" -encoding UTF8 | ConvertFrom-Json

   return $resourceGroup.resourceGroup
}
#create-resourcegroup testauto