#!/bin/sh

if pgrep -x "wlsunset" > /dev/null; then
	pkill -x "wlsunset"
else 
	wlsunset -l 44.8 -L 20.4 &
fi
