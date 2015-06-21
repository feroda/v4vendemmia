#!/bin/bash

#Definizioni
TITLE="V4Vendemmia 0.3"         #Titolo
PASSWORD="PDP"                  #Password
LOGFILE="v4vendemmia.log"	#Nome del Log

dirname="$1"
V4VPATH=$(dirname $0) 		#Cartella V4V

#Setting up things
source $V4VPATH/V4V/functions/Init.sh
if [ $? != "0" ]
then 
	exit 
fi

#Funzione USB
USB ()
{
	ISO=$(source $V4VPATH/V4V/functions/IsoChoice.sh)			
	if [ -z $ISO ]
	then
		return
	fi
	
	DEVICE=$(source $V4VPATH/V4V/functions/UsbChoice.sh)
	if [ -z $DEVICE ]
	then
		return
	fi

	source $V4VPATH/V4V/functions/IsoWrite.sh
}
###################################

DVD ()
{
	ISO=$(source $V4VPATH/V4V/functions/IsoChoice.sh)			
	if [ -z $ISO ]
	then
		return
	fi

	eject
	DEVICE="/media/cdrom"	
	source $V4VPATH/V4V/functions/IsoWrite.sh
}

##################################

###Main###

while [ 1 ]
do
	#Imposto Contatore	
    	cont=$(cat $V4VPATH/V4V/data/$LOGFILE | wc -l)
	
	choice=$(whiptail --title "Menu Principale" --backtitle "$TITLE" --cancel-button "Esci" --menu "Scegli:" 20 78 8 \
	"1" "Installa un sistema libero su USB" \
	"2" "Masterizza un sistema libero su CD/DVD" \
	"3" "Qualche info su di noi" \
	"4" "Aiuto" \
	" " "     " \
	" " "     " \
	" " "     " \
	"$cont" "ISO distribuite finora" 3>&1 1>&2 2>&3)  

	if [ $? = "1" ]
	then
		PASS=$(whiptail --backtitle "$TITLE" --passwordbox "Digita la password per uscire." 8 78 --title "Password" 3>&1 1>&2 2>&3)
		if [ $PASS = $PASSWORD ]
		then 
			exit
		fi
	fi
	
	case $choice 
	in
		1)	USB
		 	;;
		3)	whiptail --title "$TITLE" --backtitle "$TITLE"  --msgbox "$(cat $V4VPATH/V4V/data/ABOUT.txt)" 10 70 3>&1 1>&2 2>&3
			;;
		4)	source $V4VPATH/V4V/functions/HelpDialog.sh
			;;			
	esac 	
done
