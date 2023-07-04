# Script designed for SyncroMSP
# You will need to create 2 custom fields for the customer's username and password.
# Create script variables for $cun(Comet username) and $cpw(Comet Password)

# --- SERVER INFO ---
$username = "comet-api-username"
$password = "Y0urP@ssw0rd"
$server= "backup.domainname.com"
$port = "443"
$servicename = 'backup.delegate'
$command = "c:\IT-Support\install.exe /CONFIGURE=${cun}:${cpw}"

# --- Make sure Temp Folder Exist ---
$dir = "C:\IT-Support"
if(!(Test-Path -Path $dir )){
    New-Item -ItemType directory -Path $dir
    Write-Host "New folder created"
}
else
{
  Write-Host "Folder already exists"
}

# FIND THE ARCHITECTURE SO WE KNOW WHAT VERSION TO DOWNLOAD
# This will download directly from the Comet server via the API
if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit")
    {
    $arch = "64"
    Invoke-Webrequest -Uri "https://${server}:${port}/api/v1/admin/branding/generate-client/windows-x86_64-zip" -Method POST -Body @{Username="${username}"; AuthType="Password"; Password="${password}"} -OutFile "C:\IT-Support\comet.zip"
    } else {
    $arch = "32"
    Invoke-Webrequest -Uri "https://${server}:${port}/api/v1/admin/branding/generate-client/windows-x86_32-zip" -Method POST -Body @{Username="${username}"; AuthType="Password"; Password="${password}"} -OutFile "C:\IT-Support\comet.zip"
    }
    
If (Get-Service $serviceName -ErrorAction SilentlyContinue) {
    If ((Get-Service $serviceName).Status -eq 'Running') {
        # do nothing
        write-host "Backup Service Already Installed"
    } Else {
        Write-Host "$serviceName found, but it is not running for some reason."
        write-host "starting $servicename"
        start-service $serviceName
        write-host "Service not running. Starting"
    }
} Else {
    Write-Host "$serviceName not found - need to install"
    # Function allows us to unzip the file.
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    function Unzip
    {
        param([string]$zipfile, [string]$outpath)

        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
    }
    Unzip "C:\IT-Support\comet.zip" "C:\IT-Support\"
    
    CD\
    CD C:\IT-Support
    iex $command
    
    Start-Sleep -s 10
    Remove-Item 'C:\IT-Support\install.dat'
    Remove-Item 'C:\IT-Support\install.exe'
    Remove-Item 'C:\IT-Support\comet.zip'
    

}

