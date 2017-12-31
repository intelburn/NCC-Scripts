#!/bin/bash

#Set SYNC to where Resilio is downloading the files to
SYNC=
#Use select structure to locate drive for use as destination
echo "Select destination:"
select drive in /media/$(whoami)/*/ ;
do
	dest=$drive
	break
done
#Test for an _sync in destination drive, if none is present create on
if [ ! -d ${dest}_sync ]; then
	mkdir ${dest}_sync
	echo "created"
fi
#set the destination to include an _sync
dest=${dest}_sync/
#Perform an rsync with the arguments for using the checksum, display verbose info, recursively, delete items from the destination not in the source, and to exclude the hidden files made by BT Sync
rsync -c -v -r --delete --exclude=.* $SYNC/$dest
echo "Done"
