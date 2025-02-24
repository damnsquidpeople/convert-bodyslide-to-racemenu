if ( -NOT (Test-Path "$PSScriptRoot/CBBE-XML-Input")) {
    Write-Output 'Input directory not found, creating directory and exiting.'
    New-Item -Path "$PSScriptRoot/CBBE-XML-Input" -ItemType Directory | Out-Null
}

if ( -NOT (Test-Path "$PSScriptRoot/CBBE-To-JSON Output*")) {
    Write-Output 'Output directory not found, creating directory and exiting.'
    #New-Item -Path "$PSScriptRoot/CBBE-To-JSON Output" -ItemType Directory | Out-Null
    New-Item -Path "$PSScriptRoot/CBBE-To-JSON Output - Big Presets/SKSE/Plugins/StorageUtilData/RaceMenuMorphsCBBE/Presets" -ItemType Directory | Out-Null
    New-Item -Path "$PSScriptRoot/CBBE-To-JSON Output - Small Presets/SKSE/Plugins/StorageUtilData/RaceMenuMorphsCBBE/Presets" -ItemType Directory | Out-Null
}
# Load all XML files in directory, and iterate through them one at a time.
$XML_Directory = Get-ChildItem "$PSScriptRoot/CBBE-XML-Input/"

foreach ($XML_File in $XML_Directory) {

# Grab and import an XML file in the same directory as the script. Run with only one at a time.
# [XML]$XML = Get-Content "$PSScriptRoot/CBBE-XML-Input/*.XML"
[XML]$XML = Get-Content "CBBE-XML-Input/$XML_File"

<# if ( -NOT (Test-Path "$PSScriptRoot/CBBE-To-JSON Output/SKSE/Plugins/StorageUtilData/RaceMenuMorphsCBBE/Presets/")) {
    New-Item -Path "$PSScriptRoot/CBBE-To-JSON Output/SKSE/Plugins/StorageUtilData/RaceMenuMorphsCBBE/Presets/" -ItemType Directory | Out-Null
} #>

$Presets = $XML.SliderPresets.Preset

$Size_Arr = @("Big", "Small")

$XML_Arr = [PSCustomObject]@{
    'morphs' = $Obj_Arr
}

$Valid_Node_Arr = @(
    '7B Lower',
    '7B Upper', 
    '7BLeg_v2', 
    'AnkleSize', 
    'AppleCheeks', 
    'AreolaPull_v2', 
    'AreolaSize', 
    'ArmpitShape_v2', 
    'Arms',
    'Back', 
    'BackArch', 
    'BackValley_v2', 
    'BackWing_v2', 
    'Belly', 
    'BellyFrontDownFat_v2', 
    'BellyFrontUpFat_v2', 
    'BellySideDownFat_v2', 
    'BellySideUpFat_v2', 
    'BellyUnder_v2', 
    'BigBelly', 
    'BigButt',
    'BigTorso', 
    'BreastCenter', 
    'BreastCenterBig',
    'BreastCleavage', 
    'BreastFlatness', 
    'BreastFlatness2', 
    'BreastGravity2', 
    'BreastHeight', 
    'BreastPerkiness', 
    'BreastSideShape', 
    'BreastTopSlope', 
    'BreastUnderDepth', 
    'BreastWidth', 
    'Breasts' 
    'BreastsConverage_v2', 
    'BreastsFantasy', 
    'BreastsGone', 
    'BreastsNewSH',
    'BreastsNewSHSymmetry', 
    'BreastsPressed_v2', 
    'BreastsSmall', 
    'BreastsSmall2', 
    'BreastsTogether', 
    'Butt',
    'ButtClassic',
    'ButtCrack', 
    'ButtDimples', 
    'ButtNarrow_v2', 
    'ButtPressed_v2', 
    'ButtSaggy_v2', 
    'ButtShape2', 
    'ButtSmall', 
    'ButtUnderFold', 
    'CBPC', 
    'CalfFBThicc_v2', 
    'CalfSize', 
    'CalfSmooth', 
    'ChestDepth', 
    'ChestWidth',  
    'ChubbyArms', 
    'ChubbyButt', 
    'ChubbyLegs', 
    'ChubbyWaist', 
    'Clavicle_v2', 
    'CrotchBack', 
    'CrotchGap', 
    'Cutepuffyness', 
    'DoubleMelon', 
    'FeetFeminine',
    'ForearmSize', 
    'Groin', 
    'HipBone', 
    'HipCarved', 
    'HipForward', 
    'HipNarrow_v2', 
    'HipUpperWidth', 
    'Hips', 
    'KneeHeight', 
    'KneeShape', 
    'KneeTogether_v2', 
    'LegShapeClassic',
    'LegSpread_v2', 
    'LegsThin', 
    'MuscleAbs', 
    'MuscleArms', 
    'MuscleBack_v2', 
    'MuscleButt', 
    'MuscleLegs', 
    'MuscleMoreAbs_v2', 
    'MuscleMoreArms_v2', 
    'MuscleMoreLegs_v2', 
    'MusclePecs', 
    'NavelEven', 
    'NipBGone', 
    'NippleDip', 
    'NippleDistance', 
    'NippleDown', 
    'NippleInvert_v2', 
    'NippleLength', 
    'NippleManga', 
    'NipplePerkManga',
    'NipplePerkiness', 
    'NipplePuffy_v2', 
    'NippleShy_v2', 
    'NippleSize', 
    'NippleSquash1_v2', 
    'NippleSquash2_v2', 
    'NippleThicc_v2', 
    'NippleTip', 
    'NippleTipManga', 
    'NippleTube_v2', 
    'NippleUp', 
    'OldBaseShape', 
    'PregnancyBelly', 
    'PushUp', 
    'RibsMore_v2', 
    'RibsProminance', 
    'RoundAss', 
    'ShoulderSmooth', 
    'ShoulderTweak',
    'ShoulderWidth', 
    'SlimThighs', 
    'SternumDepth', 
    'SternumHeight', 
    'ThighFBThicc_v2', 
    'ThighInsideThicc_v2', 
    'ThighOutsideThicc_v2', 
    'Thighs', 
    'TummyTuck', 
    'UNPHip_v2', 
    'VanillaSSEHi', 
    'VanillaSSELo', 
    'Waist', 
    'WaistHeight', 
    'WideWaistLine', 
    'WristSize'
)

$Default_File_Hash = [Ordered]@{}

ForEach ($Valid_Node in $Valid_Node_Arr) {

    $Valid_Node = [PSCustomObject]@{
        Name  = $Valid_Node
        value = [PSCustomObject]@{
            value = 0
        }
    }

    $Default_File_Hash[$Valid_Node.Name] = $Valid_Node.Value
}


$New_Default_Hash = $Default_File_Hash

ForEach ($Size_String in $Size_Arr) {

    $Size = $Size_String

    ForEach ($Preset in $Presets) {
        
        $Obj_Arr = [Ordered]@{}
        $Obj_Arr.Clear()

        if ($XML_File.BaseName -eq 'CBBE Presets Compendium') {
            $Name = $Preset.Name
        } 
        
        else {
            $Name = $XML_File.BaseName
        }
        

        ForEach ($Item in $Preset.SetSlider) {

            if (($Item.Size -eq $Size) -and ($Valid_Node_Arr -Contains $Item.Name)) {
                
                ForEach ($Valid_Node in $Valid_Node_Arr) {

                    $Valid_Node = [PSCustomObject]@{
                        Name  = $Valid_Node
                        value = [PSCustomObject]@{
                            value = 0
                        }
                    }
                                
                    $Default_File_Hash[$Valid_Node.Name] = $Valid_Node.Value

                }

                $Node = [PSCustomObject]@{
                    Name  = $Item.Name
                    Size  = $Item.Size
                    value = [PSCustomObject]@{
                        value = $Item.Value / 100
                    }
                }

                $Obj_Arr = $Obj_Arr + [Ordered]@{ $Node.Name = $Node.Value }

                $XML_Arr = @{
                    morphs = $New_Default_Hash
                }

                ForEach ($key in $Obj_Arr.GetEnumerator()) {
                    
                    $New_Default_Hash[$Key.Name] = $Key.Value

                }

                ($XML_Arr | ConvertTo-Json -Compress -Depth 5) | ConvertFrom-Json | ConvertTo-Json -Depth 5 | Out-File "$PSScriptRoot/CBBE-To-JSON Output - $Size Presets/SKSE/Plugins/StorageUtilData/RaceMenuMorphsCBBE/Presets/$Name - $Size.json" -Encoding ascii      
                
            }        

            <# ElseIf (($Item.Size -EQ $Size) -AND ($Valid_Node_Arr -NotContains $Item.Name)) {

                # Debug - Make sure we're skipping incompatible XML Nodes
                # Write-Output $Item.Name was skipped.
            } #>
        } Write-Output "Preset - $Name - $Size was created in $Size folder."
    } 
} 
}