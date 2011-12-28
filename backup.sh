#!/bin/sh

if [ -z $CONFIGDIR ] ; then
if [ "`uname -s`" = "Darwin" ] ; then
	CONFIGDIR=/Library/WebObjects/Configuration/rujel
	if [ -z $2 ] ; then
		TARGET=/Users/Shared/rujel/backup
	fi
else
	CONFIGDIR=$NEXT_ROOT/Local/Library/WebObjects/Configuration/rujel
	if [ -z $2 ] ; then
		TARGET=/var/lib/rujel/backup
	fi
fi
fi

if [ -z $TARGET ] ; then
	TARGET=$2
fi

CONF=$CONFIGDIR/modules/database.plist
if [ ! -e $CONF ] ; then
	echo "DataBase configuration file not found"
	exit 1
fi

USERNAME=`sed -n "s/.*<key>username<\/key>[^a-z]*<string>\(.*\)<\/string>.*/\1/p" $CONF`
if [ -z $USERNAME ] ; then
	USERNAME=`sed -n "/<key>username<\/key>/,/<\/string>/ s/.*<string>\(.*\)<\/string>.*/\1/p" $CONF`
fi

PASSWORD=`sed -n "s/.*<key>password<\/key>[^a-z]*<string>\(.*\)<\/string>.*/\1/p" $CONF`
if [ -z $PASSWORD ] ; then
	PASSWORD=`sed -n "/<key>password<\/key>/,/<\/string>/ s/.*<string>\(.*\)<\/string>.*/\1/p" $CONF`
fi

if [ ! -z $PASSWORD ] ; then
	PASSWORD="--password=$PASSWORD"
fi

FILE=`pwd`
mkdir -p $TARGET
cd $TARGET
TARGET=$FILE

if [ "`uname -s`" = "Darwin" ] ; then
	FILE="RujelBackup_`date -j -v -1m +%F`_$KEY.sql.bz2"
else
	FILE="RujelBackup_`date -d \"1 month ago\" +%F`_$KEY.sql.bz2"
fi

if [ "$1" != "week" ] ; then
	CONF=$CONFIGDIR/rujel.plist
	if [ -e $CONF ] ; then
		NYM=`sed -n "s/.*<key>newYearMonth<\/key>[^a-z]*<[a-z]*>\([0-9]*\)<\/[a-z]*>.*/\1/p" $CONF`
		if [ -z $NYM ] ; then
			NYM=`sed -n "/<key>newYearMonth<\/key>/,/<\/[a-z]*>/ s/.*<[a-z]*>\([0-9]*\)<\/[a-z]*>.*/\1/p" $CONF`
		fi
	fi
	if [ -z $NYM ] ; then
		NYM=7
	else
		NYM=$(($NYM+1))
	fi
	BASE="RujelStatic"
	YEAR=`date +%Y`
	if [ $NYM -gt `date +%m` ] ; then
		YEAR=$(($YEAR-1))
	fi

	if [ $NYM -eq `date +%m` ] ; then
		BASE="$BASE RujelYear$YEAR"
		YEAR=$(($YEAR-1))
	fi
	BASE="$BASE RujelYear$YEAR"
	if [ "$1" = "day" ] ; then
		KEY="day"
		for f in RujelBackup_*_$KEY.sql.bz2 ; do
			if [ -e $f -a "$FILE" \> "$f" ] ; then
				rm $f
			fi
		done
	elif [ "$1" = "conf" ] ; then
		BASE=
		KEY="conf"
	else
		KEY="all"
		BASE="$BASE VseLists RujelUsers Contacts"
	fi
else
	KEY=$1
	BASE="VseLists RujelUsers Contacts"
	for f in RujelBackup_*_$KEY.sql.bz2 ; do
		if [ -e $f -a "$FILE" \> "$f" ] ; then
			rm $f
		fi
	done
fi

if [ ! -z "$BASE" ] ; then
	echo "Backing up databases: $BASE ..."
	FILE="RujelBackup_`date +%F`_$KEY.sql"
	if mysqldump -u $USERNAME $PASSWORD -r $FILE --single-transaction -B $BASE ; then
		bzip2 -f $FILE
		echo "Backup saved $FILE.bz2"
	else
		rm $FILE
	fi
fi

if [ "$KEY" = "all" -o "$KEY" = "conf" ] ; then
	echo "Backing up Rujel configuration: RujelConfig_`date +%F`_conf.tar.bz2"
	tar -cj -f "RujelConfig_`date +%F`.tar.bz2" -C $CONFIGDIR/.. rujel
fi

cd $TARGET