function get-sophossgversion {
    <#
    .SYNOPSIS
        Function to retreive UTM and API Version
    .DESCRIPTION
        Function to retreive UTM and API Version
    .PARAMETER Credential
        Specifies the credential to use
    .PARAMETER WebSession
        Specifies the WebSession to use
    .PARAMETER SGSite
        Specifies the URI
    .EXAMPLE
        $cred = get-crendatial
        get-sophossgversion -credential $cred -SGSite "https://firewallsg:4444/" 
    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        PSObject version
    #>


    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]
        $token,

        [parameter(Mandatory=$true)]
        [string]
        $SGSite
    )

    Process {
        
                try {
        
                    
        
                    #build the Uri 
                    
                    $uri = $SGSite + "/api/status/version/"

                    $SophosVersionJsonData = invoke-sophossgapi -token $token -uri $uri -method Get 

                    return Convert-SophosSgJsonToHastable -JsonObject $SophosVersionJsonData


                }
                catch {
                    write-host $_.Exception
                }
        


            }



}