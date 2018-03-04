function Get-SophosSGPhysicalInterface {
    <#
    .SYNOPSIS
        Function to retreive physical interface object
    .DESCRIPTION
        Function to retreive physical interface object, itfhw/ethernet/ X /interface/ethernet/
        Optionnal parameter InterfaceMacAddress filter the object by Mac Adress
    .PARAMETER Token
        Specifies the security token for Sophos RestFull API
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER InterfaceMacAddress
        Specifies the MacAddress for the interface
        Format example 00:15:5d:25:e1:07
    .EXAMPLE
        Get-SophosSGPhysicalInterface -Token "XXXXXX" -SGSite "https://firewallsg:4444/" 
        retreive all Physical interfaces present on the Firewall 
        Get-SophosSGPhysicalInterface -Token "XXXXXX" -SGSite "https://firewallsg:4444/"  -InterfaceMacAddress "00:15:5d:25:e1:07"
        Retreive the Physical interface associate with the Mac Address 00:15:5d:25:e1:07

    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        Array of Hastable With data from Itfhw and interface
    #>

    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$true)]
        $Token,

        [parameter(Mandatory=$true)]
        $SGSite,

        [parameter(Mandatory=$false)]
        $InterfaceMacAddress

    )

    Process {

        $Result = new-object System.Collections.ArrayList

 

        if ($PSBoundParameters['mac']) {
                  $Tempitfs = new-object System.Collections.ArrayList
       
           foreach($if in $itfhw)
           {
       
               if ($if.mac = $mac) 
               {
                   $Tempitfs.Add($if)
                   $itfhw = $Tempitfs
                   Break 
               }
       
           }
       
       
        }
       
       
       foreach ($value in $itfs)
       {
       
           
           
           $reMappedItfMap = $value
       
           foreach ($val in $alleth) {
             
             
             
               
                if($val.itfhw -eq $value._ref) {
                   [string]$prefix = ($val._type).Replace("interface/","")
                   write-host "match"
       
                   foreach($Key in $val.GetEnumerator())
                   {
                       $newName =  $prefix + $key.name
                  
       
                       $reMappedItfMap.add($newname,$key.Value)
                   
                   
                   }
               
            }
           }
       
           $Result.Add($reMappedItfMap) > $null
           Remove-Variable -Name reMappedItfMap 
       }

       return $result


    }

}