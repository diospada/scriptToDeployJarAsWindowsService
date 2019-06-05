#!/bin/bash
#param serviceName installationDir jarName
serviceName=$1
installationDir=$2
jarName=$3
cat $installationDir/template_linux.txt | sed s+%SERVICE_NAME%+$serviceName+g | sed s+%INSTALLATION_DIR%+$installationDir+g | sed s+%JAR_NAME%+$jarName+g > $serviceName.service
systemctl stop $serviceName.service
mv $serviceName.service /etc/systemd/system
systemctl daemon-reload
systemctl start $serviceName.service
systemctl enable $serviceName.service
