#!/bin/bash

if [ -z "$1" ]; then
    echo "Utilizzo: $0 <iso>"
    exit 100
fi

if [ ! -f "$1" ];  then
    echo "$1 non è un file!"
    echo "Utilizzo: $0 <iso>"
    exit 101
fi

#Here choose device type with wiptail
device_type=chosen_type



iso="$1"
device=/dev/sdb

read -p "Stai per scrivere l'immagine $iso sul device $device. Sei sicuro [y/N]? " scelta

if [ "$scelta" = "y" ] || [ "$scelta" = "Y" ]; then
    echo "Questa è l'operazione che avrei eseguito sul tuo sistema"
    echo "Se ti interessa rimuovi 'echo' davanti al comando dd"
    echo "Ma stai attento perche' se non scrivi il dispositivo giusto potrai trovarti con un sistema inusabile!"
    if [ "$device_type" = "usb" ]; then
        echo sudo dd if="${iso}" of="${device}"
    else if [ "$device_type" = "cd" ] || [ "$device_type" = "dvd" ]; then 
        echo sudo wodim dev="${device}" driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v "${iso}" 
    fi
    fi
    espeak -v it "Fatto tutto. Goditi la tua $iso" 2> /dev/null
else
    espeak -v it "Paura eh?!?! Ricorda: meglio un giorno da leoni..." 2> /dev/null
fi
