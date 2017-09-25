#!/bin/bash

# Definizioni
TITLE="V4Vendemmia 0.3"         # Titolo
PASSWORD="PDP"                  # Password

dirname="$1"

# Controllo se è stata passata correttamente la DIR delle ISO
if [ -z "$1" ]
then
    echo "Utilizzo: $0 <directory>"
    exit 101
fi
 
if [ ! -d "$1" ]
then
    echo "$1 non è una directory!"
    echo "Utilizzo: $0 <directory>"
    exit 102
fi

# Controlla se lo script ha permessi di ROOT
if [ "$EUID" -ne 0 ]
then
    echo "V4Vendemmia ha bisogno dei permessi di ROOT"
    exit 103
fi

# Disattivo messaggi bash
/bin/dmesg -n 1

# Controllo dei hdd che non potranno essere scritti
whiptail --backtitle "$TITLE" --msgbox "Assicurati di NON aver inserito la chiavetta su cui vuoi che gli utenti scrivano i sistemi operativi!" 10 70

# Devices non scrivibili
DEVICES_UNWRITABLE="$(lsblk -d -n -o NAME)"


# Funzione USB
USB ()
{
    # Construisco una lista delle iso partendo dalla DIR
    OPTIONS=$(ls -l -h "$dirname" | egrep *.iso | awk '{print $9" "$5"B"" off"}')

    # Controllo se esistono delle ISO
    if [ -z "$OPTIONS" ]
    then
        whiptail --backtitle "$TITLE" --msgbox "Nessuna ISO trovata!\nAssicurati che la directory sia giusta." 10 50 3>&1 1>&2 2>&3
        return
    fi
     
    iso=
            
    # Selezione della ISO
    while [ -z "$iso" ]        
    do      
        iso=$(whiptail --backtitle "$TITLE" --radiolist "Scegli il sistema da portarti a casa:" 25 65 20 ${OPTIONS} 3>&1 1>&2 2>&3)
        if [ -z "$iso" ]
        then
            whiptail --backtitle "$TITLE" --yesno "Sicuro di voler tornare al menu?" 7 36 3>&1 1>&2 2>&3
            if [ $? == "0" ]
            then    
                return
            fi
        fi
    done
	

    DEVICES_AVAILABLE=

    # Cerco il device su cui devo scrivere
    while [ -z "$DEVICES_AVAILABLE" ]
    do
        DEVICES_AVAILABLE="$(lsblk -d -n -o NAME)";

        for device in $DEVICES_UNWRITABLE
        do
            DEVICES_AVAILABLE="$(echo $DEVICES_AVAILABLE | sed s/$device//g)";
        done

        if [ -z "$DEVICES_AVAILABLE" ]
        then
            whiptail --backtitle "$TITLE" --yesno "Inserisci la tua chiavetta USB! \n\nATTENZIONE:(il contenuto verrà cancellato!)" 10 50 --yes-button="Fatto!" --no-button="Cancel" 3>&1 1>&2 2>&3
            if [ $? == "1" ]
            then
                whiptail --backtitle "$TITLE" --yesno "Sicuro di voler tornare al menu?" 10 50 3>&1 1>&2 2>&3
                if [ $? == "0" ]
                then
                    return
                fi
            fi
        else
            DEVICES_AVAILABLE=$(echo $DEVICES_AVAILABLE | tr -d ' ');
            DEVICE="/dev/$DEVICES_AVAILABLE";
        fi
    done

    whiptail --backtitle "$TITLE" --yesno "Stai per scrivere l'immagine $iso sul device $DEVICE. Sei sicuro?" 12 45 3>&1 1>&2 2>&3
    if [ $? == "0" ]
    then
        # Scrivo su device
        (pv -n "${dirname}"/"${iso}" | /bin/dd of="${DEVICE}") 2>&1 | whiptail --backtitle "$TITLE" --gauge "Please wait..." 7 100 0
        espeak -v it "Fatto tutto. Goditi la tua $iso!" 2> /dev/null &
        whiptail --backtitle "$TITLE" --msgbox "Fatto tutto. Goditi la tua $iso!" 10 40

        # Salvo nel log
        echo "$HOSTNAME" "$iso" $(date '+%A %W %Y %X') >> "v4vendemmia.log"
    else
        espeak -v it "Paura eh?! Ricorda: meglio un giorno da leoni..." 2>/dev/null &
        whiptail --backtitle "$TITLE" --msgbox "Paura eh?! Ricorda: meglio un giorno da leoni..." 10 40
    fi
}


DVD ()
{
    # Selezione ISO

	eject
	DEVICE="/media/cdrom"
    # Scrivo ISO
}


# Main
while [ 1 ]
do
	# Imposto Contatore	
    cont=$(cat "v4vendemmia.log" | wc -l)
	
	choice=$(whiptail --title "Menu Principale" --backtitle "$TITLE" --cancel-button "Esci" --menu "Scegli:" 20 78 8 \
	"1" "Installa un sistema libero su USB" \
	"2" "Masterizza un sistema libero su CD/DVD (prossimamente!)" \
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
		3)	whiptail --title "$TITLE" --backtitle "$TITLE"  --msgbox "PDP Free Software User Group <info@pdp.linux.it>\n\nTributo al admstaff diretto da Renzo Davoli\n\nLicense: GNU Affero GPLv3" 12 60 3>&1 1>&2 2>&3

			;;
		4)	whiptail --title "$TITLE" --backtitle "$TITLE" --msgbox "Usa:\nFrecce	 Spostarti\nSpazio	 Selezionare\nInvio	  Confermare" 10 30
			;;			
	esac 	
done
