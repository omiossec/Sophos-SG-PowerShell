function remove-SophosSGMasq {
    <#
    .SYNOPSIS
        Function to remove a masquerading configuration rule from the Sophos RestFull API
    .DESCRIPTION
        Function to remove a masquerading configuration rule from the Sophos RestFull API
        Masquerading enable to masq an IP or an internal network behind a public IP. 
        It is a special case of SNAT
    .PARAMETER token
        Specifies the security token for Sophos RestFull API
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER Ref
        Specifies the ref to retreive

    .EXAMPLE
        remove-SophosSGMasq -token "udshdhfd87dhdkj" -uri https://firewallsg:4444 -ref "ref_XXXXX"
        remove de the masquerading rule with the red

    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
         
    #>

    [cmdletbinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory=$true)]
        [string]
        $Token,

        [parameter(Mandatory=$true)]
        [string]
        $SgSite,

        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ObjectRef
    )


    $uri = $SGSite + "/api/objects/packetfilter/masq/" + $ObjectRef 

    write-verbose $uri

    if ($PSCmdlet.ShouldProcess($ObjectRef, "Deleting the Masquerading rule")) {

        invoke-sophossgapi -token $token -uri $uri -method Delete 

    }


}