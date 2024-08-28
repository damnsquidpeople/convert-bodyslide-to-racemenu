@ECHO OFF
cd /d "%~dp0"
echo Loading your CBBE Bodyslide presets, please be patient . . .
powershell -executionpolicy bypass -file "./convert-bodyslide-to-racemenu.ps1"
echo Finished converting your CBBE Bodyslides to Racemenu Morph Presets :)
pause