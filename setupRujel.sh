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
    if [ -d ${WOAPPSFOLDER}/$f ] ; then
      mv ${WOAPPSFOLDER}/$f $BACKUP
      echo "rm -rf ${WOAPPSFOLDER}/$f" >> $BACKUP/restore.tmp
      echo "cp -r $f ${WOAPPSFOLDER}/" >> $BACKUP/restore.tmp
    fi
    # install app
    cp -r $f $WOAPPSFOLDER
    chown -R _appserver:_appserveradm $WOAPPSFOLDER/$f
    # make symlink to WebServerResources
    if [ -d $f/Contents/WebServerResources ] ; then
        mkdir -p ${WEBFOLDER}/$f/Contents/
        ln -fns ${WOAPPSFOLDER}/$f/Contents/WebServerResources ${WEBFOLDER}/$f/Contents/WebServerResources
    fi
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
        if [ -d ${FRAMEWORKSFOLDER}/$f ] ; then
          mv ${FRAMEWORKSFOLDER}/$f ../$BACKUP/Frameworks/
          echo "rm -rf ${FRAMEWORKSFOLDER}/$f" >> $BACKUP/restore.tmp
          echo "cp -r Frameworks/$f ${FRAMEWORKSFOLDER}/" >> ../$BACKUP/restore.tmp
        fi
        # install framework
        cp -r $f $FRAMEWORKSFOLDER
        chown -R root:_appserveradm $FRAMEWORKSFOLDER/$f
        # make symlink to WebServerResources
        if [ -d $f/WebServerResources ] ; then
            mkdir -p ${WEBFOLDER}/Frameworks/$f
            ln -fns  ${FRAMEWORKSFOLDER}/$f/WebServerResources ${WEBFOLDER}/Frameworks/$f/WebServerResources
        fi
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
if [ ! -e ${CONFIGFOLDER} ] ; then
    mkdir -p ${CONFIGFOLDER}
fi

## SiteConfig

if [ -e ${CONFIGFOLDER}/SiteConfig.xml ] ; then
    if grep -iq "rujel" ${CONFIGFOLDER}/SiteConfig.xml ; then
        echo
    else
        mv ${CONFIGFOLDER}/SiteConfig.xml $BACKUPFOLDER/
        if [ -e /etc/init.d/webobjects ] ; then
            /etc/init.d/webobjects stop
        else
            /etc/init.d/womonitor stop
            /etc/init.d/wotaskd stop
        fi
        if [ $LOCALROOT != "/opt/apple/Local" ] ; then
            PATTERN=`echo $LOCALROOT | sed 's/\//\\\\\\//g'`
            sed "s/\/opt\/apple\/Local/$PATTERN/g" SiteConfig.xml > ${CONFIGFOLDER}/SiteConfig.xml
        else
            cp SiteConfig.xml ${CONFIGFOLDER}/
        fi
        chown _appserver:_appserveradm ${CONFIGFOLDER}/SiteConfig.xml
        if [ -e /etc/init.d/webobjects ] ; then
            /etc/init.d/webobjects start
        else
            /etc/init.d/wotaskd start
            /etc/init.d/womonitor start
        fi
    fi
else
    cp SiteConfig.xml ${CONFIGFOLDER}/
fi

## Setup

if [ -e ${CONFIGFOLDER}/RUJELsetup ] ; then
    mv ${CONFIGFOLDER}/RUJELsetup $BACKUPFOLDER/
fi
cp -r RUJELsetup ${CONFIGFOLDER}/

CONFIGFOLDER=${CONFIGFOLDER}/rujel

if [ ! -e ${CONFIGFOLDER} ] ; then
    mkdir -p ${CONFIGFOLDER}
fi

## RujelReports
if [ -d RujelReports ] ; then
    if [ -d ${CONFIGFOLDER}/RujelReports ] ; then
        mkdir -p $BACKUPFOLDER/RujelReports
        cd RujelReports
        echo "updating RujelReports"
        updateFolder ${CONFIGFOLDER}/RujelReports $BACKUPFOLDER/RujelReports
        cd ..
    else
        cp -r RujelReports ${CONFIGFOLDER}/
        chown -R _appserver:_appserveradm ${CONFIGFOLDER}/RujelReports
        chmod -R u+w RujelReports
        echo "RujelReports installed"
    fi
    if [ -e ${CONFIGFOLDER}/RujelReports/CustomReport/Woks.plist ] ; then
        mv ${CONFIGFOLDER}/RujelReports/CustomReport/Woks.plist $BACKUPFOLDER/RujelReports/CustomReport/
    fi
else
    echo "RujelReports not found"
fi

## Settings

if [ ! -e ${CONFIGFOLDER}/rujel.plist ] ; then
    echo "Installing settings"
    if [ -e ${CONFIGFOLDER}/modules ] ; then
        mv ${CONFIGFOLDER}/modules $BACKUPFOLDER/
    fi
    cp -r RUJELsetup/required ${CONFIGFOLDER}/modules
#    cp RUJELsetup/recommended/* ${CONFIGFOLDER}/modules/
    cd logging
        PATTERN=`echo $LOCALROOT | sed 's/\//\\\\\\//g'`
        for f in *.properties ; do
        if [ -f $f ] ; then
            if [ -e ${CONFIGFOLDER}/$f ] ; then
                mv ${CONFIGFOLDER}/$f $BACKUPFOLDER
            fi
            sed "s/\\/Library/$PATTERN&/g" $f > ${CONFIGFOLDER}/$f
        fi
        done
    cd ..
    chown -R _appserver:_appserveradm ${CONFIGFOLDER}
    echo "Please edit settings in URL http://server_url/Apps/WebObjects/PListWOEditor.woa"
fi

cd ..
rmdir $BACKUP/Configuration > /dev/null 2>&1
fi
echo ""

rmdir -p  $BACKUP/Frameworks > /dev/null 2>&1
if [ -d $BACKUP ]
then
  if [ -e $BACKUP/restore.tmp ] ; then
      echo "#!/bin/sh" > $BACKUP/restore.sh
      cat $BACKUP/restore.tmp >> $BACKUP/restore.sh
      rm -f $BACKUP/restore.tmp
      chmod 755 $BACKUP/restore.sh
  fi
    echo "Previous version backed up in folder: "$BACKUP
fi

echo "Rujel setup complete"
