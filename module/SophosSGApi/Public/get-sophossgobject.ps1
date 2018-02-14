function get-sophossgobjects {
    <#
    .SYNOPSIS
        Function to retreive object by ref or all objects  from the Sophos RestFull API
    .DESCRIPTION
        Function to retreive object by ref or all objects  from the Sophos RestFull API
    .PARAMETER Credential
        Specifies the credential to use
    .PARAMETER WebSession
        Specifies the WebSession to use
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER Ref
        Specifies the Reg
    .PARAMETER Object
        Specifies the Object to search
        Firewall, Nat, Hosts, Masquerading, InterfacesIP, InterfacesNetwork, InterfacesVlan, InterfaceEth
    .EXAMPLE
        $cred = get-crendatial
        get-sophossgobjects -credential $cred -SGSite "https://firewallsg:4444/" -object nat
        retreive all nat rules
        get-sophossgobjects -credential $cred -SGSite "https://firewallsg:4444/" -object Firewall -ref "REF_XXXX" 
        retreive the definittion of the rule with the REF REF_XXX
    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        Web session variable
    #>


    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]
        $token,

        [parameter(Mandatory=$true)]
        [string]
        $SGSite,

        [parameter(Mandatory=$false)]
        [string]
        $ref,

        [parameter(Mandatory=$true)]
        [ValidateSet("Firewall", "Nat", "Hosts", "Masquerading", "InterfacesIP", "InterfacesNetwork", "InterfacesVlan", "InterfaceEth")]
        $ObjectRef
    )

    Process {

        try {



            $uri = $SGSite + "/api/objects/"

            switch ($ObjectRef)
            {
                "Firewall" { $uri = $uri + "packetfilter/packetfilter/" }
                "Nat" { $uri = $uri + "packetfilter/nat/" }
                "Hosts" { $uri = $uri + "network/host/" }
                "Masquerading" { $uri = $uri + "packetfilter/masq/" }
                "InterfacesIP" { $uri = $uri + "network/interface_address/" }
                "InterfacesNetwork" { $uri = $uri + "network/interface_network/" }
                "InterfacesVlan" { $uri = $uri + "interface/vlan/" }
                "InterfaceEth" { $uri = $uri + "interface/ethernet/" }
            }

            if ($PSBoundParameters['ref']) {
                $uri = $uri + $ObjectRef
            }

            $ObjectJsonData = invoke-sophossgapi -token $token -uri $uri -method Get 

            return Convert-SophosSgJsonToHastable -JsonObject $ObjectJsonData


        }

        catch {
            write-host $_.Exception
        }

    }

}