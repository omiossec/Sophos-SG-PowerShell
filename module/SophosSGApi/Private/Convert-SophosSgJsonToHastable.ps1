function Convert-SophosSgJsonToHastable {
    <#
    .SYNOPSIS
        Function to convert Json response to Hashtable
    .DESCRIPTION
        Function to convert Json response to Hashtable
    .PARAMETER JsonObject
        Specifies the Json To convert
    .EXAMPLE
        
       Convert-SophosSgJsonToHastable -JsonObject $var
        retreive a Hashtable 

    .NOTES
        Oliver Miossec 
        @omiossec_med
        https://www.linkedin.com/in/omiossec/
    .OUTPUTS
        Hashtable
#>

    [CmdletBinding()]
    
    param (
        [Parameter(Mandatory=$true)]
        $JsonObject
    )

    process {
       
        if ($JsonObject -eq $null) {
            return $null
        }


        if ($JsonObject -is [System.Array]) {

                foreach ($Item in $JsonObject) {
                    Convert-SophosSgJsonToHastable -JsonObject $Item
                    
                }
         

        } elseif ($JsonObject -is [System.Object]) { 
            
            $HashTable = @{}
            foreach ($property in $JsonObject.PSObject.Properties) {
                $HashTable[$property.Name] =  $property.Value
            }
            return $HashTable
        } else {

            return $JsonObject
        }
    }
}