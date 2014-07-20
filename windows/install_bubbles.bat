netsh firewall set opmode mode = DISABLE profile = ALL
msiexec.exe  /i  z:\windows\splunk-6.0.2-196940-x64-release.msi  AGREETOLICENSE=Yes INSTALLDIR=c:\Splunk SPLUNKD_PORT=1901 WEB_PORT=1900  /l*v z:\windows\install\install_splunk-6.0.2-196940-x64-release.msi.log.%COMPUTERNAME%.%RANDOM%  LOGON_USERNAME="cupcaketest@splunk.local" LOGON_PASSWORD="OJ&*qR7x9OZm" /quiet
copy z:\windows\authentication.conf c:\splunk\etc\system\local\authentication.conf
c:\splunk\bin\splunk.exe restart -f

