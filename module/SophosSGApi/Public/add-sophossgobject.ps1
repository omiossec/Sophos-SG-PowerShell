function Add-SophosSGObject {
    <#
    .SYNOPSIS
        Function to add a new Sophos SG Object
    .DESCRIPTION
        Function to add a new Sophos SG Object
        - network
        - Host
        - Dns Host
        - Range
        
    .PARAMETER Token
        Specifies the security token for Sophos RestFull API
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER SophosObject
        Define which object to add 
        It can be a Network Object, a Host Object, a Dns Host Object or a Network Range Object 
        Value Network, Host, DnsHost, Range
    .PARAMETER SophosObjectName
        A string representing the value to create
    .PARAMETER SophosObjectValue
        A string representing the value to create
    .PARAMETER SophosObjectValue
        Comment about this object
        Optionnal

    .EXAMPLE
        Add-SophosSGObject -Token "xxxxxx" -SGSite "https://firewallsg:4444/" -SophosObject Host -SophosObjectName Host -SophosObjectName "ServerA" -SophosObjectValue "10.11.1.2"



    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        String Variable with the Sophos SG _Ref value
    #>

    [cmdletbinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory=$true)]
        $Token,

        [parameter(Mandatory=$true)]
        $SGSite,

        [parameter(Mandatory=$true)]
        [ValidateSet("Network","Host","DnsHost")]
        $SophosObject,

        [parameter(Mandatory=$true)]
        $SophosObjectName,

        [parameter(Mandatory=$true)]
        $SophosObjectValue,

        [parameter(Mandatory=$false)]
        $SophosObjectComment

    )

    Process {

        
        $HeaderParam = @{
            "X-Restd-Err-Ack"="all"
            "X-Restd-Lock-Override"="yes"
        }

        $body = @{
            "comment" = $SophosObjectComment
            "name" = $SophosObjectName
        }

        switch ($SophosObject)
        {
            "Network" {
                $Body.Add("address",$SophosObjectValue)
                $Body.Add("name",$SophosObjectValue)
                $Body.Add("Comment",$SophosObjectComment)
                }

            }

            "Host" {
                 
            }


            "DnsHost" {
                 
            }

        }



    }

}