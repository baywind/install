#!/bin/sh

if [ "`uname -s`" = "Darwin" ]
then
    #Mac OS
    echo "I am on MacOS"
    WOROOT=/System
    LOCALROOT=
else
    #Unix
    echo "I am on Unix"
    if [ -z ${NEXT_ROOT} ]
        then 
        echo "Error! : \${NEXT_ROOT} environment variable is not set"
        exit 1
    fi
    WOROOT=${NEXT_ROOT}
    LOCALROOT=${NEXT_ROOT}/Local
fi

WEBFOLDER=${LOCALROOT}/Library/WebServer/Documents/WebObjects

BACKUP=backup
i=0
while [ -d $BACKUP ] ; do
    i=$(($i+1))
    BACKUP=backup${i}
done
mkdir -p $BACKUP/Frameworks/

# Applications
WOAPPSFOLDER=${LOCALROOT}/Library/WebObjects/Applications
mkdir -p $WOAPPSFOLDER

i=0
for f in *.woa; do
    # backup
    if [ -d ${WOAPPSFOLDER}/$f ]
    then mv ${WOAPPSFOLDER}/$f $BACKUP
    fi
    # install app
    cp -r $f $WOAPPSFOLDER
    chown -R _appserver:_appserveradm $WOAPPSFOLDER/$f
    # make symlink to WebServerResources
    mkdir -p ${WEBFOLDER}/$f/Contents/
    ln -sf ${WOAPPSFOLDER}/$f/Contents/WebServerResources ${WEBFOLDER}/$f/Contents/
    i=$(($i+1))
done
echo "Installed "$i" WO Applications"

if [ -d Frameworks ]
then
    # Frameworks
    FRAMEWORKSFOLDER=${LOCALROOT}/Library/Frameworks
    mkdir -p $FRAMEWORKSFOLDER

    i=0
    cd Frameworks
    for f in *.framework; do
        # backup
        if [ -d ${FRAMEWORKSFOLDER}/$f ]
        then mv ${FRAMEWORKSFOLDER}/$f ../$BACKUP/Frameworks/
        fi
        # install framework
        cp -r $f $FRAMEWORKSFOLDER
        chown -R root:_appserveradm $FRAMEWORKSFOLDER/$f
        # make symlink to WebServerResources
        mkdir -p ${WEBFOLDER}/Frameworks/$f
        ln -sf  ${FRAMEWORKSFOLDER}/$f/WebServerResources ${WEBFOLDER}/Frameworks/$f/WebServerResources
        i=$(($i+1))
    done
    cd ..
    echo "Installed "$i" Frameworks"
fi

# Configuration files

if [ -d Configuration ] ; then
cd Configuration

CONFIGFOLDER=${LOCALROOT}/Library/WebObjects/Configuration

for f in * ; do
if [ -e $f ]
then
    if [ -e ${CONFIGFOLDER}/$f ]
    then
        if [ -n $1 -a $1 = "-c" ]
        then mv ${CONFIGFOLDER}/$f $BACKUP
        else echo $f" already exists"
## Here I will implement recursive reports update
#            if [ -d $f ] ; then
#            i=0
#            mkdir -p $BACKUP/$f
#                for r in $f/* ; do
#                    if [ -d $r ]
#                    then
#                        recursive update
#                    else
#                    if [ -e ${CONFIGFOLDER}/$r ]
#                    then mv ${CONFIGFOLDER}/$r ../$BACKUP/$f
#                    fi
#                    cp -r $r ${CONFIGFOLDER}/$f
#                    chown -R _appserver:_appserveradm ${CONFIGFOLDER}/$r
#                    i=$(($i+1))
#                    fi
#                done
#                echo "Updated "$i" Reports"
#            fi
        fi
    fi
    if [ ! -e ${CONFIGFOLDER}/$f ]
    then cp -r $f ${CONFIGFOLDER}/$f
    fi
else
    echo $f" not found"
fi
done
cd ..
fi
echo ""

rmdir -p  $BACKUP/Frameworks > /dev/null 2>&1
if [ -d $BACKUP ]
then
    echo "Previous version backed up in folder: "$BACKUP
fi

echo "Rujel setup complete"
