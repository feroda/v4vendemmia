#!bin/bash

###Funzione di scelta del ISO###

#Construisco una lista delle iso partendo dalla DIR
OPTIONS=$(ls -l -h "$dirname" | egrep *.iso | awk '{print $9" "$5"B"" off"}')

#Controllo se esistono delle ISO
if [ -z "$OPTIONS" ]
then
	whiptail --backtitle "$TITLE" --msgbox "Nessuna ISO trovata!\nAssicurati che la directory sia giusta." 10 50 3>&1 1>&2 2>&3
	return
fi
 
iso=
        
#Selezione della ISO
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

echo $iso

return 0
