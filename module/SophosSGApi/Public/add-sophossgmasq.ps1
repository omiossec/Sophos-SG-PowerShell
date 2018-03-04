function Add-SophosSgMasquerading {
    <#
    .SYNOPSIS
        Function to add a new masquerading rule
    .DESCRIPTION
        Function to add a new masquerading rule
        either by ref or by network/host
        
    .PARAMETER token
        Specifies the security token for Sophos RestFull API
    .PARAMETER SGSite
        Specifies the URI
    .PARAMETER SourceNatInterface
        Source nat interface by Name, the outbound interface 
    .PARAMETER SourceNatInterfaceRef
        Source nat interface by Ref, the outbound interface network/*
    .PARAMETER AdditionalAddress
        Outbound Adresse format xxxx/x
    .PARAMETER AdditionalAddressRef
        Outbound Adresse itfparams/secondary
    .PARAMETER Source
        Source Adresse format xxxx/x 
    .PARAMETER RuleName
        Optional Rule Name
    .PARAMETER SourceRef
        Source Adresse Ref network/*

    .EXAMPLE

    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        Web session variable
    #>


    [cmdletbinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory=$true)]
        [string]
        $Token,

        [parameter(Mandatory=$true)]
        [string]
        $SgSite,

        [parameter(Mandatory=$true,parametersetname="BySourceInterfaceRef")]
        [ValidateNotNullOrEmpty()]
        [string]
        $SourceNatInterfaceRef,

        [parameter(Mandatory=$true,parametersetname="BySourceInterfaceValue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $SourceNatInterface,

        [parameter(Mandatory=$false,parametersetname="ByAdditionalAddressRef")]
        [ValidateNotNullOrEmpty()]
        [string]
        $AdditionalAddressRef,

        [parameter(Mandatory=$false,parametersetname="ByAdditionalAddressValue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $AdditionalAddress,

        [parameter(Mandatory=$false,parametersetname="BySourceRef")]
        [ValidateNotNullOrEmpty()]
        [string]
        $SourceRef,

        [parameter(Mandatory=$false,parametersetname="BySourceValue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Source,

        [parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]
        $RuleName

    )


    begin {

        switch($PsCmdlet.ParameterSetName) {

            "BySourceValue" {

            }

            "ByAdditionalAddressValue" {

            }

            "BySourceInterfaceValue" {
                
            }

        }

    }

    process {


    }

    end {


    }






}