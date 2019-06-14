.  "$PSScriptRoot\rg.ps1"
.  "$PSScriptRoot\nsg.ps1"
.  "$PSScriptRoot\network.ps1"
.  "$PSScriptRoot\inputconfig.ps1"

$RootPath=(get-item $PSScriptRoot ).parent.FullName

#resoruce config object
$resourceGroup=rg-get-config-json "$RootPath\$configfile"

#share variable
$resourceGroupName=$resourceGroup.name
$vpcNumber=$resourceGroup.vnet.vpcNumber
$vnetname=inputconfig-replace-placeholder-ifany ($resourceGroup.vnet.name)
$subscription_id=$resourceGroup.subscription
$addressPrefix=inputconfig-replace-placeholder-ifany ($resourceGroup.vnet.addressPrefix)
$location=$resourceGroup.location

function engine-up(){
    
    config-rg
    config-vnet
    config-nsg
    config-subnet
    config-peering

}
function engine-update(){
    
    config-vnet
    config-nsg
    config-subnet
    config-peering

}

function engine-down(){
    $resourceGroup=rg-get-config-json "$RootPath\$configfile"
    $resourceGroupName=$resourceGroup.name
    rg-delete-resourcegroup $resourceGroupName
}   
function config-nsg(){
    foreach ($nsg in $resourceGroup.nsg){
        $nsgname=$nsg.name
        nsg-create-nsg $nsgname $resourceGroupName $location
        foreach($rule in $nsg.rules){
            $rulename=$rule.name
            $rulepriority=$rule.priority
            $rulesource=$rule.source
            $rulesourcePort=$rule.sourcePort
            $ruledestination=$rule.destination
            $ruledestinationPort=$rule.destinationPort
            $ruletype=$rule.type
            $ruleprotocol=$rule.protocol
            nsg-add-rule $nsgname "$resourceGroupName" "$rulename" "$rulepriority" " $rulesource" "$rulesourcePort" "$ruledestination" "$ruledestinationPort" "$ruletype" "$ruleprotocol"

        }
    }
}
function config-subnet(){
    foreach ($subnet in $resourceGroup.vnet.subnets){
        $subnetIndex=$subnet.subnetIndex
        $subnetname=inputconfig-replace-placeholder-ifany ($subnet.name)
        $subnetaddressPrefix=inputconfig-replace-placeholder-ifany ($subnet.addressPrefix)
        $subnetnsgname=$subnet.nsgname
        network-create-subnet "$subnetname" $vnetname $resourceGroupName "$subnetaddressPrefix" $location "$subnetnsgname"

    }
}

function config-peering(){
    foreach ($peering in $resourceGroup.vnet.peering){
        $peeringfromResourceGroupName = inputconfig-replace-placeholder-ifany ($peering.fromResourceGroupName)
        $peeringtoResourceGroupName = inputconfig-replace-placeholder-ifany ($peering.toResourceGroupName)
        $peeringname = inputconfig-replace-placeholder-ifany ($peering.name)
        $peeringfromVnetName = inputconfig-replace-placeholder-ifany ($peering.fromVnetName)
        $peeringtoVnetName = inputconfig-replace-placeholder-ifany ($peering.toVnetName)
        $peeringoptions = $peering.options
        network-create-peering "$peeringfromResourceGroupName" "$peeringtoResourceGroupName" "$peeringname" "$peeringfromVnetName" "$peeringtoVnetName" "$peeringoptions"

    }
}
function config-rg(){
    rg-create-resourcegroup $resourceGroupName $location
}

function config-vnet(){
    network-create-vnet $vnetname $resourcegroupName $addressPrefix $location
}

        
        
        

        
        

        
        

        
        