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
    ln -fns ${WOAPPSFOLDER}/$f/Contents/WebServerResources ${WEBFOLDER}/$f/Contents/WebServerResources
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
        ln -fns  ${FRAMEWORKSFOLDER}/$f/WebServerResources ${WEBFOLDER}/Frameworks/$f/WebServerResources
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

## Configuration variants
if [ -d variants ] ; then
    cd variants
    echo "Choose initial settings variant:"
    echo ""
    i=0;
    for v in *; do
    if [ -d $v ] ; then
        i=$(($i+1))
        echo "$i) $v"
    fi
    done
    echo ""
    echo "Enter variant number (default none):"
    read num
    if [ ! -z $num ] ; then
    i=1;
    for v in *; do
    if [ -d $v ] ; then
        if [ $num = $i ] ; then
            echo "Installing $v"
            num=0
            cd $v
            updateFolder ${CONFIGFOLDER} $BACKUPFOLDER
            echo ""
            echo "Dont forget to modify installed settings to match your system"
            cd ..
#        else
#            echo "$num != $i"
        fi
        i=$(($i+1))
    fi
    done
    cd ..
    if [ $num != "0" ] ; then
        echo "\"$num\" is illegal number. Settings installation skipped"
    else
        ## Common configuration
        for f in * ; do
        if [ -f $f ] ; then
            if [ -e ${CONFIGFOLDER}/$f ] ; then
                mv ${CONFIGFOLDER}/$f $BACKUPFOLDER
            fi
            cp -r $f ${CONFIGFOLDER}/$f
        fi
        done
    fi
    else
        echo "Settings installation skipped"
        cd ..
    fi
else
    echo "Settings variants not found"
fi

## RujelReports
if [ -d RujelReports ] ; then
    mkdir -p $BACKUPFOLDER/$f
    cd RujelReports
    echo "updating RujelReports"
    updateFolder ${CONFIGFOLDER}/RujelReports $BACKUPFOLDER/RujelReports
    cd ..
else
    echo "RujelReports not found"
fi

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
