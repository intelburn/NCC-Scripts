#!/bin/bash
if [ $(ls /sync/Ballston-New/ | grep --quiet .wav)==0 ] && [ $(ls /sync/Ballston-New | grep --quiet !sync)==1 ] ; then
	for recording in /sync/Ballston-New/*.wav; do
		compressed=`basename $recording .wav`.mp3
		ffmpeg -i $recording -b:a 320k -f mp3 /sync/Ballston-Record/$compressed
	done
	rsync --checksum /sync/Ballston-Record/*.mp3 /sync/Ballston-Archive/
	for item in $(find /sync/Ballston-Record/ -name *.mp3 -mtime +30); do
        	echo "Currently removing $item"
        	rm $item
	done
	rm /sync/Ballston-New/*.wav
fi
