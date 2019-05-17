param([String]$serviceName,[String]$jarName)
$serviceNameXml = "$serviceName.xml"
$serviceNameExe = "$serviceName.exe"

write-output "Installing windows service $serviceName"
$service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($service.Status -eq "Running"){
  &$ServiceName 'stop'
}
#create xml file necessary to install microservice as windows service
powershell -Command "(gc deploy_service.xml) -replace '%SERVICE_NAME%', '$serviceName' -replace '%JAR_NAME%', '$jarName' | Out-File -encoding ASCII $serviceNameXml"
#rename exe that need to invoked to install microservice as windows service
Rename-Item -Path 'WinSW.NET4.exe' -NewName $serviceNameExe
