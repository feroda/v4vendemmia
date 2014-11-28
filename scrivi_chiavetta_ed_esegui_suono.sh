#!/bin/bash

if [ -z "$1" ]; then
    echo "Utilizzo: $0 <directory>"
    exit 100
fi

if [ ! -d "$1" ];  then
    echo "$1 non è una directory!"
    echo "Utilizzo: $0 <directory>"
    exit 101
fi


dirname="$1"
iso_list=$(cd "$dirname" && ls *.iso)

OPTIONS=""
c=0;
for iso_file in $iso_list; do 
    c=$(($c+1))
    OPTIONS="$OPTIONS $iso_file $c   off"
done

while [ -z "$iso" ]; do
    iso=$(whiptail --radiolist "Scegli il sistema da portarti a casa" 25 65 20 ${OPTIONS} 3>&1 1>&2 2>&3)
done

iso_absolute_path="$dirname"/"$iso"

#Here choose device type with whiptail
device_type=usb

device=/dev/sdc

read -p "Stai per scrivere l'immagine $iso sul device $device. Sei sicuro [y/N]? " scelta

if [ "$scelta" = "y" ] || [ "$scelta" = "Y" ]; then
    echo "Questa è l'operazione che avrei eseguito sul tuo sistema"
    echo "Se ti interessa rimuovi 'echo' davanti al comando dd"
    echo "Ma stai attento perche' se non scrivi il dispositivo giusto potrai trovarti con un sistema inusabile!"
    if [ "$device_type" = "usb" ]; then
        /bin/dd if="${iso_absolute_path}" of="${device}"
    else if [ "$device_type" = "cd" ] || [ "$device_type" = "dvd" ]; then 
        echo sudo wodim dev="${device}" driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v "${iso_absolute_path}" 
    fi
    fi
    espeak -v it "Fatto tutto. Goditi la tua $iso" 2> /dev/null
else
    espeak -v it "Paura eh?!?! Ricorda: meglio un giorno da leoni..." 2> /dev/null
fi
