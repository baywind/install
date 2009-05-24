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

updateFolder() {
#params: targetDir, backupDir
for f in * ; do
    if [ -d $f -a -d $1/$f ] ; then
        cd $f
        if [ -d $2 ] ; then
            mkdir -p $2/$f
            updateFolder $1/$f $2/$f
        else
            updateFolder $1/$f
        fi
        cd ..
    else
        if [ -e $1/$f ] ; then
            if [ -d $2 ] ; then
                mv $1/$f $2
            else
                rm -r $1/$f
            fi
        fi
        cp -r $f $1
    fi
done
}

if [ -d Configuration ] ; then
mkdir -p $BACKUP/Configuration/
BACKUPFOLDER=`pwd`/$BACKUP/Configuration
cd Configuration

CONFIGFOLDER=${LOCALROOT}/Library/WebObjects/Configuration

for f in * ; do
if [ -f $f ]
then
    if [ -e ${CONFIGFOLDER}/$f ]
    then
        if [ "$1" = "-c" ]
        then mv ${CONFIGFOLDER}/$f $BACKUPFOLDER
        else echo $f" already exists"
        fi
    fi
    if [ ! -e ${CONFIGFOLDER}/$f ]
    then cp -r $f ${CONFIGFOLDER}/$f
    fi
elif [ -d $f ] ; then
    mkdir -p $BACKUPFOLDER/$f
    cd $f
    echo "updating "$f
    updateFolder ${CONFIGFOLDER}/$f $BACKUPFOLDER/$f
    cd ..
else
    echo $f" not found"
fi
done
cd ..
rmdir $BACKUP/Configuration > /dev/null 2>&1
fi
echo ""

rmdir -p  $BACKUP/Frameworks > /dev/null 2>&1
if [ -d $BACKUP ]
then
    echo "Previous version backed up in folder: "$BACKUP
fi

echo "Rujel setup complete"
