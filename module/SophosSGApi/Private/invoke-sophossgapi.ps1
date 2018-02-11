function invoke-sophossgapi {
    <#
    .SYNOPSIS
        Function to send request to the sophos api
    .DESCRIPTION
        Function to send request to the sophos api
    .PARAMETER token
        Specifies the token credential 
    .PARAMETER URI
        Specifies the URI with the port
    .PARAMETER Methode
        Specifies the HTTP method, GET, POST, DELETE, PATCH, PUT
    .PARAMETER BODY
        Hashtable 
    .EXAMPLE
        
       invoke-sophossgapi -token xxxxxxx -uri "https://firewallsg:4444/object/network/host" -methode GET
        retreive a pscostumobject 

    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        PsCustumObject 

#>


    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        $token,
        [parameter(Mandatory=$true)]
        $uri,
        [parameter(Mandatory=$true)]
        [ValidateSet("get","post","delete","patch","put")]
        $method,
        [parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty]
        [hashtable]$body
    )

    begin {

  
        # use .net to use TLS 1.2 used in Sophos SG web server
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $secureToken = ConvertTo-SecureString $token -AsPlainText -Force
        $AuthentificationToken = New-Object System.Management.Automation.PSCredential("token", $secureToken)
        
    }

    process {

        try {

            if ($PSBoundParameters.ContainsKey('body'))
            {
                $headers = @{
                    "X-Restd-Err-Ack"="all"
                    "X-Restd-Lock-Override"="yes"
                }

                $body = $body | ConvertTo-Json

                $result = Invoke-RestMethod -Method $methode -uri $uri -Credential $AuthentificationToken -ContentType "application/json" -Headers $headers
    
    
            }
            else {
                $result = Invoke-RestMethod -Method $methode -uri $uri -Credential $AuthentificationToken
    
            }
            
            
    
            return $result

        }
        catch [System.Net.WebException] {
            
            if ($_.Exception.Response.StatusCode -eq "NotFound")
            {
                # nothing found send a $null instead of error
                return $null
            }
            else {

                throw "Receive a http exception StatusCode " + $_.Exception.Response.StatusCode 
                write-debug $_.Exception
            }
        
        }
        catch {
            write-debug $_.Exception
            throw "Receive a general error " +  $_.Exception
        }

       
    }

    end {
    }


}