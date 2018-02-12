function get-sophossgmasq { 
    <#
    .SYNOPSIS
        Function to retreive masquerading configuration  from the Sophos RestFull API
    .DESCRIPTION
        Function to retreive masquerading configuration from the Sophos RestFull API
    .PARAMETER token
        Specifies the security token for Sophos RestFull API
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER Ref
        Specifies the ref to retreive, optional
    .PARAMETER Resolve
        Resolve Ip and Service by Name and IP/HOST/Service Definition
    .EXAMPLE
        get-sophossgnat -token "udshdhfd87dhdkj" -uri https://firewallsg:4444 
        retreive all the masquerading object
        get-sophossgnat -token "udshdhfd87dhdkj"-uri https://firewallsg:4444 -Ref REF_NetHosXXXX
        retreive the masquerading object for the ref _ref  
    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        MAP 
    #>

    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]$token,
        [parameter(Mandatory=$true)]
        [string]$SGSite,
        [parameter(Mandatory=$false)]
        [string]$ref,
        [parameter(Mandatory=$false)]
        [switch]$resolve
    )
    
    $uri = $SGSite + "/api/objects/packetfilter/masq/" 

    if ($PSBoundParameters['ref']) {
        $uri = $uri + $ref
    }


    $MasqueradingJsonData = invoke-sophossgapi -token $token -uri $uri -method Get 

    return Convert-SophosSgJsonToHastable -JsonObject $MasqueradingJsonData

}