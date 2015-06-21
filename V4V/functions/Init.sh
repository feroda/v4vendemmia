#!/bin/bash

###Funzione di controllo###

#Controllo delle dipendenze
dep=$(source $V4VPATH/V4V/functions/Depend.sh pv)
if [ "$dep" = 0 ]
then
	echo "Pacchetto pv mancante! #apt-get install pv"
	exit
fi

dep=$(source $V4VPATH/V4V/functions/Depend.sh espeak)
if [ "$dep" = 0 ]
then
	echo "Pacchetto espeak mancante! #apt-get install espeak"
	exit
fi

#Controllo se è stata passata correttamente la DIR delle ISO
if [ -z "$1" ]
then
    echo "Utilizzo: $0 <directory>"
    return 101
fi
 
if [ ! -d "$1" ]
then
    echo "$1 non è una directory!"
    echo "Utilizzo: $0 <directory>"
    return 102
fi

#Controlla se lo script ha permessi di ROOT
if [ "$EUID" -ne 0 ]
then
        echo "V4V ha bisogno dei permessi di ROOT"
        return 103
fi

#Disattivo messaggi bash
/bin/dmesg -n 1

#Controllo dei hdd che non potranno essere scritti
whiptail --backtitle "$TITLE" --msgbox "Assicurati di NON aver inserito la chiavetta su cui vuoi che gli utenti scrivano i sistemi operativi!" 10 70

DEVICES_UNWRITABLE="$(lsblk -d -n -o NAME)"

return 0
