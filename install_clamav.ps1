Invoke-WebRequest -Uri https://www.clamav.net/downloads/production/clamav-0.105.0.win.x64.msi -OutFile c:\clamav-win-x64.msi -UseBasicParsing;
Start-Process -FilePath "c:\clamav-win-x64.msi" -ArgumentList "/qn", "/l*vs", "c:\install.log" -Wait;

Copy-Item "clamd.conf" "C:\Program Files\ClamAV\clamd.conf"; 
Copy-Item "freshclam.conf" "C:\Program Files\ClamAV\freshclam.conf";

Start-Process -FilePath "C:\Program Files\ClamAV\clamd" -ArgumentList "--install-service" -Wait;
Start-Process -FilePath "C:\Program Files\ClamAV\freshclam" -ArgumentList "--install-service" -Wait
