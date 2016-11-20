#!/bin/bash
read key_in < <(./cuepie.app)
path='/opt/music/'
play="$path""key_""$key_in"

if [[ -e $play ]]; then
	/usr/bin/omxplayer -o local $play
else
	echo "not found: $play"
fi
