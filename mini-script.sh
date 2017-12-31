#!/bin/bash
#This is where the usere selects where the flash drive is mounted
echo "Select source:"
echo "To help determine the correct source look on the desktop"
select drive in /Volumes/*/ ;
do
	src=$drive
	break
done
clear	#clear the screen
#Tries to detect a _sync directory
if [ -d ${src}_sync ]; then
	src+=_sync/
else
#If there is no _sync directory the script defaults to a mode of prompting the user for directory structure information
	echo "Is there a folder that contains the sync (Y/n)? "
	echo "If you are unsure use Finder to help you locate the sync."
	read subdir
	clear
#If the sync is in the root directory
	if [ "$subdir" = 'n' ] || [ "$subdir" = 'N' ]; then
		src=$src
	else
#This is to get input from the user as to the location of the synced directory
		echo "Select the folder containing the sync:"
		echo "Use Finder to help you locate the folder that contains the sync."
		select folder in $src*/ ;
			do
				src=$folder
				break
				clear
			done
	fi
fi
clear
rsync -c --progress -r --delete --exclude=.* $src ~/media
rsync -c --progress -r ~/media/ ~/media-archive
echo "Done"
