#!/bin/bash

dpkg -s $1 1>/dev/null 2>/dev/null

if [ $? == 0 ]
then 
	echo 1
else
	echo 0
fi

return
