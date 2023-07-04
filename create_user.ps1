# Designed for SyncroMSP
# Add custom fields for your clients username and password.
# Enter a username and password in these fields.
# In the script create runtime variables $cun(Comet Username) and $cpw(Comet Password)

Import-Module $env:SyncroModule

# --- SERVER INFO ---
$username = "api-username"
$password = "Y0urAPIP@ssw0rd"
$server= "backup.youdomain.com"
$port = "8060"

Invoke-Webrequest -Uri "https://${server}:${port}/api/v1/admin/add-user" -UseBasicParsing -Method POST -Body @{Username="${username}"; AuthType="Password"; Password="${password}"; TargetUser=$cun; TargetPassword=$cpw; StoreRecoveryCode="1"} | select Content
