#!/bin/bash

#Definizioni
TITLE="V4Vendemmia 0.2"		#Titolo
PASSWORD="PDP"			#Password

#Controllo se è stata passata correttamente la DIR delle ISO
if [ -z "$1" ]
then
    echo "Utilizzo: $0 <directory>"
    exit 100
fi

if [ ! -d "$1" ]
then
    echo "$1 non è una directory!"
    echo "Utilizzo: $0 <directory>"
    exit 101
fi

#Controlla se lo script ha permessi di ROOT
if [ "$EUID" -ne 0 ] 
then 
	echo "V4V ha bisogno dei permessi di ROOT"
  	exit 102
fi

#Disattivo messaggi bash
/bin/dmesg -n 1
dirname="$1"

whiptail --backtitle "$TITLE" --msgbox "Assicurati di NON aver inserito la chiavetta su cui vuoi che gli utenti scrivano i sistemi operativi!" 10 70 3>&1 1>&2 2>&3

#Controllo dei disk che non potranno essere scritti
DEVICES_UNWRITABLE="$(lsblk -d -n -o NAME)"

################################
	
#Funzione di scelta del ISO			
ISO_CHOICE ()
{
	#Construisco una lista delle iso partendo dalla DIR
	OPTIONS=$(ls -l -h "$dirname" | egrep *.iso | awk '{print $9" "$5"B"" off"}')
	iso=

	#Selezione della ISO
	while [ -z "$iso" ] 
	do
		iso=$(whiptail --backtitle "$TITLE" --radiolist "Scegli il sistema da portarti a casa:" 25 65 20 ${OPTIONS} 3>&1 1>&2 2>&3)
		if [ -z "$iso" ] 
		then
			whiptail --backtitle "$TITLE" --yesno "Sicuro di voler tornare al menu?" 25 65 3>&1 1>&2 2>&3
			if [ $? == "0" ] 
			then
				return
			fi		
		fi
	done

	echo $iso
 	return
} 

#################################

#Funzione USB
USB ()
{
	#Riazzero le variabli
	iso=$(ISO_CHOICE)			
	if [ -z $iso ]
	then
		return
	fi

	DEVICES_AVAILABLE=

	#Cerco il device su cui devo  scrivere
	while [ -z "$DEVICES_AVAILABLE" ] 
	do
	  	DEVICES_AVAILABLE="$(lsblk -d -n -o NAME)"; 

	  	for device in $DEVICES_UNWRITABLE 
		do 
	   		DEVICES_AVAILABLE="$(echo $DEVICES_AVAILABLE | sed s/$device//g)"; 
	 	done
		
		if [ -z "$DEVICES_AVAILABLE" ] 
		then
			whiptail --backtitle "$TITLE" --yesno "Inserisci la chiavetta che vuoi sacrificare..." 25 65 --yes-button="Fatto!" --no-button="Cancel" 3>&1 1>&2 2>&3
			if [ $? == "1" ] 
			then
				whiptail --backtitle "$TITLE" --yesno "Sicuro di voler tornare al menu?" 25 65 3>&1 1>&2 2>&3
				if [ $? == "0" ]
				then 	
					return
	 			fi	
			fi
	 	else
			DEVICES_AVAILABLE=$(echo $DEVICES_AVAILABLE | tr -d ' ');
		fi
	done

	DEVICE=/dev/${DEVICES_AVAILABLE}

	#Ultima chance
	whiptail --backtitle "$TITLE" --yesno "Stai per scrivere l'immagine $iso sul device $DEVICE. Sei sicuro? " 25 65 3>&1 1>&2 2>&3
	if [ $? == "0" ] 
	then	
		(pv -n "${dirname}"/"${iso}" | /bin/dd of="${DEVICE}") 2>&1 | whiptail --backtitle "$TITLE" --gauge "Please wait..." 7 70 0  3>&1 1>&2 2>&3
        	espeak -v it "Fatto tutto. Goditi la tua $iso!" 2> /dev/null &
		whiptail --backtitle "$TITLE" --msgbox "Fatto tutto. Goditi la tua $iso!" 10 70 3>&1 1>&2 2>&3
		echo "$iso" "$HOSTNAME" $(date '+%A %W %Y %X') >> cont.txt 
		return
	else	
        	espeak -v it "Paura eh?! Ricorda: meglio un giorno da leoni..." 2>/dev/null &
		whiptail --backtitle "$TITLE" --msgbox "Paura eh?! Ricorda: meglio un giorno da leoni..." 10 70 3>&1 1>&2 2>&3 
		return
	fi	
}

###################################

DVD ()
{
	echo sudo wodim dev="${DEVICE}" driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v "${dirname}"/"${iso}" 
}

##################################

#Menu Principale
while [ 1 ]
do
	#Imposto Contatore	
	cont=0
	while read line           
	do           
    		cont=$(($cont+1))           
	done <cont.txt
	
	choice=$(whiptail --title "Menu Principale" --backtitle "$TITLE" --cancel-button "Esci" --menu "Scegli:" 20 78 8 \
	"1" "Installa un sistema libero su USB" \
	"2" "Qualche info su di noi" \
	" " "     " \
	" " "     " \
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
		2)	whiptail --title "$TITLE" --backtitle "$TITLE"  --msgbox "$(cat $(dirname $0)/ABOUT.txt)" 10 70 3>&1 1>&2 2>&3
			;;	
	esac 	
done
