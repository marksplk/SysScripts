REM netsh firewall set opmode mode = DISABLE profile = ALL
c:\splunk\bin\splunk.exe stop -f
msiexec.exe  /i  z:\windows\splunk-6.1.0-206881-x64-release.msi REINSTALLMODE=vomus REINSTALL=ALL AGREETOLICENSE=Yes INSTALLDIR=c:\Splunk SPLUNKD_PORT=1901 WEB_PORT=1900  /l*v z:\windows\install\install_splunk-6.1.0-206881-x64-release.msi.log.%COMPUTERNAME%.%RANDOM%  LOGON_USERNAME="splunk.local\cupcaketest" LOGON_PASSWORD="OJ&*qR7x9OZm" isMajorUpgrade=Yes isUpgradeCode=Yes /quiet
c:\splunk\bin\splunk.exe restart -f

