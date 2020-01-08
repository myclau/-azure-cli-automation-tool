
function nsg-create-nsg($_nsgname,$_resourcegp,$_location){

echo "[Create] network security group : $_nsgname "

az network nsg create --name "$_nsgname" --resource-group "$_resourcegp" --location "$_location"
echo "[completed]"
}

function nsg-add-rule(
    $_nsgname,
    $_resourcegp,
    $_rulename,
    $_priority,
    $_source_address_prefixes,
    $_source_port_ranges,
    $_destination_address_prefixes,
    $_destination_port_ranges,
    $_direction="Inbound",
    $_protocol="Tcp",
    $_description=$_rulename,
    $_access="Allow"
    

){

if($_source_address_prefixes -eq "*"){
$_source_address_prefixes = '"*"'
}
if($_source_port_ranges -eq "*"){
$_source_port_ranges = '"*"'
}
if($_destination_address_prefixes -eq "*"){
$_destination_address_prefixes = '"*"'
}
if($_destination_port_ranges -eq "*"){
$_destination_port_ranges = '"*"'
}


$command='az network nsg rule create -g "'+$_resourcegp+'" --nsg-name "'+$_nsgname+'" -n "'+$_rulename+'" --priority "'+$_priority+'" --source-address-prefixes '+$_source_address_prefixes+' --source-port-ranges '+$_source_port_ranges+' --destination-address-prefixes '+$_destination_address_prefixes+' --destination-port-ranges '+$_destination_port_ranges+' --access "'+$_access+'" --protocol "'+$_protocol+'" --description "'+$_description+'" --direction "'+$_direction+'"'

#echo "Running command:"
#echo "$command"

echo "[Apply] nsg rule :$_rulename "
Invoke-Expression $command

echo "[Completed]"
echo ""
echo ""
#az network nsg rule create -g "$_resourcegp" --nsg-name "$_nsgname" -n "$_rulename" --priority "$_priority" --source-address-prefixes "$_source_address_prefixes" --source-port-ranges "*" --destination-address-prefixes "*" --destination-port-ranges 22 3389 --access "$_access" --protocol "$_protocol" --description "$_description"

}

