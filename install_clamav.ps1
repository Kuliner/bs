Invoke-WebRequest -Uri https://www.clamav.net/downloads/production/clamav-0.105.0.win.x64.msi -OutFile c:\clamav-win-x64.msi -UseBasicParsing;
Start-Process -FilePath "c:\clamav-win-x64.msi" -ArgumentList "/qn", "/l*vs", "c:\install.log" -Wait;

$clamdConfPath = "C:\Program Files\ClamAV\clamd.conf"
$freshclamConfPath = "C:\Program Files\ClamAV\freshclam.conf"

$clamd = @{
    "TCPSocket"         = 3310
    "MaxThreads"        = 2
    "LogTime"           = "true"
    "LogFile"           = "C:\logs\clamd.log"
    "DatabaseDirectory" = "C:\db"
}

$freshclam = @{
    "DatabaseDirectory" = "C:\db"
    "DatabaseMirror"    = "database.clamav.net"
    "MaxAttempts"       = 3
    "NotifyClamd"       = "C:/Program Files/ClamAV-x64/clamav-0.105.0.win.x64/clamd.conf"
    "LogFileMaxSize"    = 20480000
    "LogTime"           = "true"
    "UpdateLogFile"     = "C:/logs/freshclam.log"
    "LogVerbose"        = "yes"
    "Checks"            = 12
}

New-Item -Path $clamdConfPath -Force
New-Item -Path $freshclamConfPath -Force

foreach ($item in $clamd.GetEnumerator()) {
    Add-Content -Value "$($item.Key) $($item.Value)" -Path $clamdConfPath
}
foreach ($item in $freshclam.GetEnumerator()) {
    Add-Content -Value "$($item.Key) $($item.Value)" -Path $freshclamConfPath
}


Start-Process -FilePath "C:\Program Files\ClamAV\clamd" -ArgumentList "--install-service" -Wait;
Start-Process -FilePath "C:\Program Files\ClamAV\freshclam" -ArgumentList "--install-service" -Wait