Invoke-WebRequest -Uri https://www.clamav.net/downloads/production/clamav-0.105.0.win.x64.msi -OutFile c:\clamav-win-x64.msi -UseBasicParsing;
Start-Process -FilePath "c:\clamav-win-x64.msi" -ArgumentList "/qn", "/l*vs", "c:\install.log" -Wait;
Copy-Item "clamd.conf" "C:\Program Files\ClamAV\clamd.conf"; 
Copy-Item "freshclam.conf" "C:\Program Files\ClamAV\freshclam.conf";

New-Item -Path "C:\logs" -ItemType "directory" -Force;
New-Item -Path "C:\db" -ItemType "directory" -Force;

Set-Location "C:\Program Files\ClamAV";

Start-Process -FilePath "C:\Program Files\ClamAV\freshclam" -verb runas;
Start-Sleep -Seconds 20;

Start-Process -FilePath "C:\Program Files\ClamAV\freshclam" -ArgumentList "--install-service" -Wait -verb runas;
Start-Process -FilePath "C:\Program Files\ClamAV\clamd" -ArgumentList "--install-service" -Wait -verb runas;

Set-Service -Name clamd -StartupType Automatic
Set-Service -Name freshclam -StartupType Automatic

net start clamd
net start freshclam
