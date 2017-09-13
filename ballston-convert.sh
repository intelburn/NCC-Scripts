#!/bin/bash
#check for changes to watch folder. This is check is in two halfs. The first checks for new .wav files in the watch folder using ls and grep. The second have makes sure that the .wav files have finished syncing. Both of these conditions must be met before conversion can start
if [ $(ls /sync/Ballston-New/ | grep --quiet .wav)==0 ] && [ $(ls /sync/Ballston-New | grep --quiet !sync)==1 ] ; then
	#loop through all of the .wav files
	for recording in /sync/Ballston-New/*.wav; do
		#set up the new names for the files that end in .mp3
		compressed=`basename $recording .wav`.mp3
		#use ffmpeg to convert te recording and send the output to the Ballston-Record directory for syncing
		ffmpeg -i $recording -b:a 320k -f mp3 /sync/Ballston-Record/$compressed
	done
	#copy the recordings to the Ballston-Archive folder for syncing using rsync
	rsync --checksum /sync/Ballston-Record/*.mp3 /sync/Ballston-Archive/
	#check for .mp3 files in Ballston-Record that are older than 30 days and delet them
	for item in $(find /sync/Ballston-Record/ -name *.mp3 -mtime +30); do
        	echo "Currently removing $item"
        	rm $item
	done
	#clean out the Ballston-New directory for next time through the script
	rm /sync/Ballston-New/*.wav
fi
