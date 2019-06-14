param(
    $operation,
    $configfile="resourcegroup.json"
)
#Import Library
.  "$PSScriptRoot\lib\engine.ps1"



#check login


$checking=az account list | ConvertFrom-Json


if($checking -eq $null){
    echo '[Error] please run "az login -e AzureChinaCloud" or "az login"'
    exit 1
}else{
    echo "[checking] az logined info"
    foreach($c in $checking){
        echo $c

    }
   echo "[OK]"
}


if($operation -eq "up"){
    echo "[checking] configfile in $PSScriptRoot\$configfile"
    if(test-path "$PSScriptRoot\$configfile"){
        echo "[OK]"
        engine-up

        echo "[Completed] Resource group with all needed setup is completed "
    }else{
        echo "[Error] Config file $PSScriptRoot\$configfile not found"
        exit 1
    }
}
elseif($operation -eq "update"){
    echo "[checking] configfile in $PSScriptRoot\$configfile"
    if(test-path "$PSScriptRoot\$configfile"){
        echo "[OK]"
        engine-update


        echo "[Completed] Resource group with all needed setup is completed "
    }else{
        echo "[Error] Config file $PSScriptRoot\$configfile not found"
        exit 1
    }
}
elseif ($operation -eq "down"){
    echo "[checking] configfile in $PSScriptRoot\$configfile"
    if(test-path "$PSScriptRoot\$configfile"){
        echo "[OK]"
        engine-down
       
         
    }else{
        echo "[Error] Config file $PSScriptRoot\$configfile not found"
        exit 1
    }

}else{
    echo "[Error] Please input correct operation : {up / down}"
    echo "syntax: .\resourcegroup.ps1 {up/down} --configfile [resourcegroup.json/yourconfigname.json]"
    exit 1

}