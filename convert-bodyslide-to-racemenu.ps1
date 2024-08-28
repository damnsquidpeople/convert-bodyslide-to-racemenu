if ( -NOT (Test-Path "$PSScriptRoot/CBBE-XML-Input")) {
    Write-Output "Input directory not found, creating directory and exiting."
    New-Item -Path "$PSScriptRoot/CBBE-XML-Input" -ItemType Directory | Out-Null
}

# Grab and import an XML file in the same directory as the script. Run with only one at a time.
[XML]$XML = Get-Content "$PSScriptRoot/CBBE-XML-Input/*.XML"

if ( -NOT (Test-Path "$PSScriptRoot/CBBE-To-JSON Output")) {
    New-Item -Path "$PSScriptRoot/CBBE-To-JSON Output" -ItemType Directory | Out-Null
}

$Presets = $XML.SliderPresets.Preset

$Size_Arr = @('big', 'small')


$XML_Arr = @{
    'morphs' = $Obj_Arr
}

$Obj_Arr = @()


 
ForEach ($Size_String in $Size_Arr) {

    $Size = $Size_String

    ForEach ($Preset in $Presets) {

        $Obj_Arr = @()
        $Name = $Preset.Name

        ForEach ($Item in $Preset.SetSlider) {
            
            if ($Item.Size -EQ $Size) {
        
                $Node = [PSCustomObject]@{
                    Name  = $Item.Name
                    Size  = $Item.Size
                    value = [PSCustomObject]@{
                        value = $Item.Value / 100
                    }
                }            
    
                $Obj_Arr += $Node.Name, $Node.Value

                $XML_Arr = @{
                    'morphs' = $Obj_Arr
                }

            ($XML_Arr | ConvertTo-Json -Depth 5).Replace('[', '{').Replace(']', '}').Replace('",', '" :').Replace('":', '" :') | Out-File "$PSScriptRoot/CBBE-To-JSON Output/$Name-$Size.JSON"

            }
            
        }        
        
    } 
}



    



