function network-create-vnet($_vnetname,$_rgname,$_address_prefixes,$_locaiton){

echo "[Create] vnet :$_vnetname "


az network vnet create --name "$_vnetname" --resource-group "$_rgname" --address-prefixes "$_address_prefixes" --location "$_locaiton"
echo "[completed]"
                      
}

function network-create-subnet($_subnetname,$_vnetname,$_rgname,$_address_prefixes,$_locaiton,$_nsgname){

echo "[Create] subnet :$_subnetname"
az network vnet subnet create --address-prefixes "$_address_prefixes" --name "$_subnetname" --resource-group "$_rgname" --vnet-name "$_vnetname" --network-security-group "$_nsgname"

<#
                               options
                              [--delegations]
                              [--network-security-group]
                              [--route-table]
                              [--service-endpoint-policy]
                              [--service-endpoints]
                              [--subscription]

#>
echo "[completed]"                     
}

# create-peering <from resource group> <to resource group> <peering name> <from vnet name> <to vnet name>
function network-create-peering($_rgname,$remote_rgname,$_peeringname,$_vnetname,$_remote_vnetname,$_flagString){
$_remote_vnet_id = "/subscriptions/$subscription_id/resourceGroups/$remote_rgname/providers/Microsoft.Network/virtualNetworks/$_remote_vnetname"

echo "[create] peering $_peeringname"
$command_string='az network vnet peering create --name "'+$_peeringname+'" --remote-vnet "'+$_remote_vnet_id+'" --resource-group "'+$_rgname+'" --vnet-name "'+$_vnetname+'" '+$_flagString
Invoke-Expression $command_string
                               <#
                               options:
                               [--allow-forwarded-traffic]
                               [--allow-gateway-transit]
                               [--allow-vnet-access]
                               [--use-remote-gateways]
                               #>

echo "[completed]"
}


