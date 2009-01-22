#!/bin/sh
WEBROOT=/Library/WebServer/Documents/
LOCALROOT=/

mkdir -p ${WEBROOT}WebObjects/Rujel.woa/Contents/
mkdir -p ${WEBROOT}WebObjects/RujelDiary.woa/Contents/
ln -s ${LOCALROOT}Library/WebObjects/Applications/Rujel.woa/Contents/WebServerResources ${WEBROOT}WebObjects/Rujel.woa/Contents/WebServerResources
ln -s ${LOCALROOT}Library/WebObjects/Applications/RujelDiary.woa/Contents/WebServerResources ${WEBROOT}WebObjects/RujelDiary.woa/Contents/WebServerResources

mkdir -p ${WEBROOT}WebObjects/Frameworks/Authentication.framework
mkdir ${WEBROOT}WebObjects/Frameworks/Reusables.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelArchiving.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelAutoItog.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelBase.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelContacts.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelCriterial.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelCurriculum.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelEduPlan.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelEduResults.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelInterfaces.framework
mkdir ${WEBROOT}WebObjects/Frameworks/RujelVseobuch.framework

ln -s  ${LOCALROOT}Library/Frameworks/Authentication.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/Authentication.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/Reusables.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/Reusables.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelArchiving.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelArchiving.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelAutoItog.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelAutoItog.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelBase.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelBase.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelContacts.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelContacts.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelCriterial.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelCriterial.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelCurriculum.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelCurriculum.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelEduPlan.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelEduPlan.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelEduResults.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelEduResults.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelInterfaces.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelInterfaces.framework/WebServerResources
ln -s  ${LOCALROOT}Library/Frameworks/RujelVseobuch.framework/WebServerResources ${WEBROOT}WebObjects/Frameworks/RujelVseobuch.framework/WebServerResources