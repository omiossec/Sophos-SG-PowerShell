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
        [parameter(Mandatory=$true, parametersetname="bySession")]
        $WebSession,
        [parameter(Mandatory=$true, parametersetname="byCredential")]
        $Credential,
        [parameter(Mandatory=$true)]
        $SGSite
    )

    Process {
        
                try {
        
                    l
        
                    #build the Uri 
                    
                    $uri = $SGSite + "/api/status/version/"

                    switch($PsCmdlet.ParameterSetName)
                    {
                        "bySession" {
                            $value = Invoke-RestMethod -Method get -uri $uri -WebSession $WebSession
                        }
        
                        "byCredential" {
                            $value = Invoke-RestMethod -Method get -uri $uri -Credential $Credential
                        }
        
                    }
        
                    return $value


                }
                catch {
                    write-host $_.Exception
                }
        


            }



}