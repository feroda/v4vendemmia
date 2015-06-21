#!/bin/bash

###Funzione di ricerca di un USB disponibile###

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
      	fi
done

echo /dev/${DEVICES_AVAILABLE}

return 0
