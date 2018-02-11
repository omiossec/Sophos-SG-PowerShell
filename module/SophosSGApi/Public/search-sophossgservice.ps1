function search-sophossgservice {

    <#
    .SYNOPSIS
        Function to search service object and retreive _ref and other data
    .DESCRIPTION
        Function to search service object and retreive _ref and other data
        tcp service
        udp service
        tcp/udp service
    .PARAMETER token
        Sophos SG API token
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER Type
        Service Type: tcp,udp,tcpudp,ip
    .PARAMETER name
        String service name to search
    .PARAMETER portnumber
        Integer ip address for range search
    .PARAMETER PortRange
        String 
    .EXAMPLE
        search-sophossgservice -token "podkjeuidj" -SGSite "https://firewallsg:4444/" -type udp -name MyService
        Search for service named MySerice using UDP protocol

        search-sophossgservice -token "podkjeuidj" -SGSite "https://firewallsg:4444/" -type tcpudp -port 546
        Search for service with the port 546 using TCP or UDP protocol

        search-sophossgservice -token "podkjeuidj" -SGSite "https://firewallsg:4444/" -type tcp -portrange 540:550
        Search for service with the port range 540 to 550 using TCP 

        search-sophossgservice -token "podkjeuidj" -SGSite "https://firewallsg:4444/" -type ip -protocol 54
        Search for IP service using the protocol 54
    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        pscostumobject of Sophos SG Object
    #>

    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        $token,
        [parameter(Mandatory=$true)]
        $SGSite,
        [parameter(Mandatory=$true)]
        [ValidateSet("tcp","udp","tcpudp","IP")]
        $type,
        [parameter(Mandatory=$true, parametersetname="setPort")]
        [ValidateRange(1,65535)]
        [int]$Port,
        [parameter(Mandatory=$true, parametersetname="setPortRange")]
        [validatepatern("\d{1,5}\:\d{1,5}")]
        [String]$PortRange,
        [parameter(Mandatory=$true, parametersetname="setIpProtocol")]
        [String]$Protocol
    )

    begin {


        }

    }
    process {

        $ProtoToUri = @{

            "tcp" = "objects/service/tcp/"
        
            "udp" ="objects/service/udp/"
        
            "tcpupd" ="objects/service/tcpudp/"
        
            "IP" = "objects/service/ip/"
        }

        $uri =  $SGSite + $ProtoToUri 

        $value = invoke-sophossgapi -token $token -uri $uri -method get 

        if ($PsCmdlet.ParameterSetName -eq "setPortRange") {
            $arPort = $PortRange.split(":")
            $porthight = [int]$arPort[0]
            $portlow = [int]$arPort[1]
        }

        foreach ($obj in $value) {

            switch($PsCmdlet.ParameterSetName)
            {
                "setPort" {
                    if ($obj.dst_high -eq $Port -and $obj.dst_low -eq $Port) {
                        return $obj
                        break
                    }
                }
                "setPortRange" {
                    if ($obj.dst_high -eq $porthight -and $obj.dst_low -eq $portlow) {
                        return $obj
                        break
                    }
                }
                "setIpProtocol" {
                    if ($obj.proto -eq $Protocol) {
                        return $obj
                        break
                    }

                }

            }


        }





    }
    end {

    }

}