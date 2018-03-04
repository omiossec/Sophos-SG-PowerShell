function search-sophossgnetworkobject {

    <#
    .SYNOPSIS
        Function to search network object and retreive _ref and other data
    .DESCRIPTION
        Function to search network object and retreive _ref and other data
        host object
        network object
        dns object
        range object
        interface_network object
    .PARAMETER Token
        Sophos SG API token
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER Type
        Service Type: host,dns,range,network
    .PARAMETER IP
        String ip address for host, network and range search
    .PARAMETER IPto
        String ip address for range search
    .PARAMETER NetMasq
        Integer masq
    .PARAMETER hostname
        string fqdn
    .PARAMETER interfacenetwork
        Switch to search into interface network object instead of network object
    .EXAMPLE 
        search-sophossgnetworkobject -token "podkjeuidj" -SGSite "https://firewallsg:4444/"  -type host -ip 192.168.10.1
        Search the host object with IP address 192.168.10.1 

        search-sophossgnetworkobject -token "podkjeuidj" -SGSite "https://firewallsg:4444/"  -type host -dns something.zzz.com
        Search the dns host object with the fqdn something.zzz.com

        search-sophossgnetworkobject -token "podkjeuidj" -SGSite "https://firewallsg:4444/"  -type network -ip 10.10.0.0 -netmasq 24
        Search the network object with the ip 10.10.0.0 and masq 255.255.255.0

        search-sophossgnetworkobject -token "podkjeuidj" -SGSite "https://firewallsg:4444/"  -type network -ip 10.10.0.0 -netmasq 24 -interfacenetwork
        Search the interface network object with the ip 10.10.0.0 and masq 255.255.255.0

        search-sophossgnetworkobject -token "podkjeuidj" -SGSite "https://firewallsg:4444/"  -type range -ip 192.168.10.1 -IPto 192.168.10.10
        Search the host object with IP range address from 192.168.10.1 to 192.168.10.10

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

        [parameter(Mandatory=$true, parametersetname="shIp")]
        [parameter(parametersetname="shRange")]
        [parameter(parametersetname="shNetwork")]
        $ip,

        [parameter(Mandatory=$true, parametersetname="shRange")]
        $IPto,

        [parameter(Mandatory=$true, parametersetname="shNetwork")]
        $netmasq,

        [parameter(Mandatory=$true, parametersetname="shHost")]
        $hostname,

        [parameter(Mandatory=$true)]
        [ValidateSet("IP","Range","Network","Hosts", "InterfacesIP", "InterfacesIPSecondary")]
        $type,
        
        [parameter(parametersetname="shNetwork")]
        [switch]$interfacenetwork

    )


    Process {

        try {
           
            $uri = $SGSite + "/api/objects/"

            switch ($type)
            {

                "IP" { $uri = $uri + "network/host/" }
                "Range" { $uri = $uri + "network/range/" }
                "Network" { 
                    if ($interfacenetwork.IsPresent -and $interfacenetwork)
                    {
                        $uri = $uri + "network/interface_network/"
                    }
                    else {
                        $uri = $uri + "network/network/"         
                    }
                    
                }
                "host" { $uri = $uri + "network/dns_host/" }
                "InterfacesIP" { $uri = $uri + "itfparams/primary/" }
                "InterfacesIPSecondary" { $uri = $uri + "itfparams/secondary/" }

                 
            }



            $value = invoke-sophossgapi -token $token -uri $uri -method get

            foreach ($obj in $value) {

                switch($PsCmdlet.ParameterSetName)
                {
                    "shIp" {
                        if ($obj.address -eq $ip) {
                            return $obj
                            break
                        }
                    }
                    "shRange" {
                        if ($obj.from -eq $ip -and $obj.to -eq $IPto) {
                            return $obj
                            break
                        }
                    }
                    "shNetwork" {

                    }
                    "shHost" {

                    }
                }


            }


        }
        catch [System.Net.WebException] {
            
            if ($_.Exception.Response.StatusCode -eq "NotFound")
            {
                return $null
            }
            else {
                write-host $_.Exception
            }
        
        }
        catch {
            write-host $_.Exception
        }






    }





}