#!/bin/bash

###Funzione di scrittura su device###

whiptail --backtitle "$TITLE" --yesno "Stai per scrivere l'immagine $ISO sul device $DEVICE. Sei sicuro?" 12 45 3>&1 1>&2 2>&3
if [ $? == "0" ]
then
	(pv -n "${dirname}"/"${ISO}" | /bin/dd of="${DEVICE}") 2>&1 | whiptail --backtitle "$TITLE" --gauge "Please wait..." 7 100 0
   	espeak -v it "Fatto tutto. Goditi la tua $ISO!" 2> /dev/null &
      	whiptail --backtitle "$TITLE" --msgbox "Fatto tutto. Goditi la tua $ISO!" 10 40
       	echo $(date '+%A %W %Y %X') "$HOSTNAME" "$ISO" >> $V4VPATH/V4V/data/$LOGFILE
else
       	espeak -v it "Paura eh?! Ricorda: meglio un giorno da leoni..." 2>/dev/null &
       	whiptail --backtitle "$TITLE" --msgbox "Paura eh?! Ricorda: meglio un giorno da leoni..." 10 40
fi

return
