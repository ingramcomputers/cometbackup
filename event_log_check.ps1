Import-Module $env:SyncroModule

# Create RMMAlerts when a backup fails

$event = Get-EventLog -LogName "application" -EntryType "error" -After (Get-Date).AddHours(-24)| Where-Object {$_.EventID -eq 52}

if($event.entrytype -eq "Error") {
  write-host "Comet Backup Errors in Event Log"
  Rmm-Alert -Category "comet_backup_failed" -Body "Comet Backup Failed on $(%computername%) - message: $($event.message)"
} else {
  write-host "No errors here"
}
