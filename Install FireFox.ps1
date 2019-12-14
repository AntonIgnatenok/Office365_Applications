# Silent Install Firefox (for Intune deployment)
## Download URL: https://www.mozilla.org/en-US/firefox/all/
### When a new version of FireFox comes out, just change the firefox version or url to the new value

#--------------------------------------------------------------------------------------------------------

# Path for the Workdir
$workdir = "C:\Intune\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "https://download.mozilla.org/?product=firefox-51.0.1-SSL&os=win64&lang=en-US"
$destination = "$workdir\firefox.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Start the installation

Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"

# Wait few Seconds for the installation to finish

Start-Sleep -s 35

# Remove the installer

Remove-Item -Force $workdir\firefox* 

#--------------------------------------------------------------------------------------------------------