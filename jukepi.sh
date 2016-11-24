#!/bin/bash
log='/var/log/jukepi.log'
# ::Handle Signales
_term() { 
  echo "`date` Caught SIGTERM signal!" >> $log 
  mpc stop; mpc clear;
  exit 0;
}
_kill() { 
  echo "`date` Caught SIGKILL signal!" $log 
  mpc stop; mpc clear;
  exit 0;
}

trap _term SIGTERM
# ::MAIN
basepath='/opt/jukepi/'
dbg=1
read key_in < <($basepath""cuepie.app)
if [[ $dbg = 1 ]]; then
	echo `date`"; "$key_in >> $log
fi
mpcsearch=`mpc search artist $key_in`
if [[ "$mpcsearch" -eq '' ]]; then
	echo `date`"; $key_in not found." >> $log
else
	mpc stop; mpc clear; mpc search artist $key_in | mpc add; mpc play
fi
exit 1

# add new rfid tag to mpd id3v2 -a "0002346991" /opt/music/<file>; mpd update
