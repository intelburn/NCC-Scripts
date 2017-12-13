#!/bin/bash
$SYNC=
#Use select structure to locate drive for use as destination
echo "Select destination:"
select drive in /media/$(whoami)/*/ ;
do
	dest=$drive
	break
done
#Determine if an _sync directory is desired
echo -n "Want _sync (y/N)? "
read subdir
if [ "$subdir" = 'y' ] || [ "$subdir" = 'Y' ]; then
	#Test for an _sync in destination drive, if none is present create on
	if [ ! -d ${dest}_sync ]; then
		mkdir ${dest}_sync
		echo "created"
	fi
	#set the destination to include an _sync
	dest=${dest}_sync/
fi
#Perform an rsync with the arguments for using the checksum, display verbose info, recursively, delete items from the destination not in the source, and to exclude the hidden files made by BT Sync
rsync -c -v -r --delete --exclude=.* $SYNC/ $dest
echo "Done"
