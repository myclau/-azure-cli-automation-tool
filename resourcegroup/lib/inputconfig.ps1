function inputconfig-replace-placeholder-ifany($_input){
    #$_input
    $command='$_input="'+$_input+'"'
    #echo $command
    Invoke-Expression "$command"
    return  $_input
}