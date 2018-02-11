<#
.Synopsis
    Pester test to verify the content of the manifest and the documentation of each functions.
.Description
    Pester test to verify the content of the manifest and the documentation of each functions.
#>
[CmdletBinding()]
PARAM(
    $ModuleName = "SophosSGApi"
)

# remove module from memory
Get-Module -Name $ModuleName | remove-module

$ManifestFile = "$(Split-path (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition))\module\$ModuleName\$ModuleName.psd1"

# Import the module and store the information about the module
$ModuleInformation = Import-module -Name $ManifestFile -PassThru

# Get the functions present in the Manifest
$ExportedFunctions = $ModuleInformation.ExportedFunctions.Values.name


# Get the functions present in the Public folder
$PublicFunctions = Get-ChildItem -path "$(Split-path (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition))\module\$ModuleName\public\*.ps1"



Describe "$ModuleName Module - Manifest"{

    Context 'Manifest'{
        It 'Should contains RootModule'{
            $ModuleInformation.RootModule|Should not BeNullOrEmpty
        }
        It 'Should contains Author'{
            $ModuleInformation.Author|Should not BeNullOrEmpty
        }

    }


}

