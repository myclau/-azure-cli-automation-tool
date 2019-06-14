
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

#create-nsg nsgname  resourcegp location
#create-nsg TEST BWT "chinaeast2"

#add-rule nsgname  resourcegp  rulename  priority  source_address_prefixes  source_port_ranges  destination_address_prefixes  destination_port_ranges direction=Inbound {option: Inbound, Outbound} protocol="Tcp" {options:*, Esp, Icmp, Tcp, Udp } description=rulename  access="Allow" {option: Allow, Deny}  
#add-rule TEST BWT AllowRemoteAccessHKOffice01 100 "61.238.47.154/32" "*" "*" "22 3389" "Inbound" "Tcp"
#add-rule TEST BWT AllowRemoteAccessHKOffice02 101 "202.126.221.56/29" "*" "*" "22 3389" "Inbound" "Tcp"
#add-rule TEST BWT AllowRemoteAccessCompanyInternalIP 102 "192.168.0.0/16" "*" "*" "22 3389" "Inbound" "Tcp"
#add-rule TEST BWT AllowDNSCompanyInternalIP 103 "192.168.0.0/16" "*" "*" "53" "Inbound" "Tcp"
#add-rule TEST BWT AllowICMPHKOffice01 104 "61.238.47.154/32" "*" "*" "*" "Inbound" "Icmp"
#add-rule TEST BWT AllowICMPHKOffice02 105 "202.126.221.56/29" "*" "*" "*" "Inbound" "Icmp"
#add-rule TEST BWT AllowICMPCompanyInternalIP 106 "202.126.221.56/29" "*" "*" "*" "Inbound" "Icmp"

<#
create-nsg RemoteAccess BWT "chinaeast2"
add-rule RemoteAccess BWT AllowRemoteAccessHKOffice01 100 "61.238.47.154/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess BWT AllowRemoteAccessHKOffice02 101 "202.126.221.56/29" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess BWT AllowRemoteAccessBJOffice01 102 "106.39.77.196/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess BWT AllowRemoteAccessBJOffice02 103 "202.77.46.252/32" "*" "*" "22 3389" "Inbound" "Tcp"


create-nsg RemoteAccess CRAWL "chinaeast2"
add-rule RemoteAccess CRAWL AllowRemoteAccessHKOffice01 100 "61.238.47.154/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess CRAWL AllowRemoteAccessHKOffice02 101 "202.126.221.56/29" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess CRAWL AllowRemoteAccessBJOffice01 102 "106.39.77.196/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess CRAWL AllowRemoteAccessBJOffice02 103 "202.77.46.252/32" "*" "*" "22 3389" "Inbound" "Tcp"


create-nsg RemoteAccess WIT "chinaeast2"
add-rule RemoteAccess WIT AllowRemoteAccessHKOffice01 100 "61.238.47.154/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess WIT AllowRemoteAccessHKOffice02 101 "202.126.221.56/29" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess WIT AllowRemoteAccessBJOffice01 102 "106.39.77.196/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess WIT AllowRemoteAccessBJOffice02 103 "202.77.46.252/32" "*" "*" "22 3389" "Inbound" "Tcp"


create-nsg RemoteAccess RCF "chinaeast2"
add-rule RemoteAccess RCF AllowRemoteAccessHKOffice01 100 "61.238.47.154/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess RCF AllowRemoteAccessHKOffice02 101 "202.126.221.56/29" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess RCF AllowRemoteAccessBJOffice01 102 "106.39.77.196/32" "*" "*" "22 3389" "Inbound" "Tcp"
add-rule RemoteAccess RCF AllowRemoteAccessBJOffice02 103 "202.77.46.252/32" "*" "*" "22 3389" "Inbound" "Tcp"
#>

#create-nsg PublicToPrivate CRAWL "chinaeast2"
#add-rule PublicToPrivate CRAWL AllowAccessFromPublicSubnet 100 "10.41.1.0/24" "*" "*" "*" "Inbound" "*"

