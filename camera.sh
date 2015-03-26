#bin/bash
BASE="1.png"
CONF="2.png"
RES="A.png"
RES_FILE="B.txt"

ffmpeg -f video4linux2 -i /dev/video0 $BASE -v quiet

while [ true ]
do

    ffmpeg -f video4linux2 -i /dev/video0 $CONF -v quiet

    compare -fuzz 75% -metric ae $BASE $CONF $RES 2>$RES_FILE
    if [ "$(cat $RES_FILE)" -lt 20 ];
    then

        espeak -v it uguali

    else

        espeak -v it diverse

    fi
    #rm $BASE $CONF $RES $RES_FILE

done
