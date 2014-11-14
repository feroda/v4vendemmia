#!/bin/bash

iso="/tmp/ciao.txt"
device=/dev/sdb

echo "Questa è l'operazione che avrei eseguito sul tuo sistema"
echo "Se ti interessa rimuovi 'echo' davanti al comando dd"
echo "Ma stai attento perche' se non scrivi il dispositivo giusto potrai trovarti con un sistema inusabile!"

echo dd if="${iso}" of="${device}" && \
espeak -v it "Fatto tutto. Goditi il tuo sistema $iso" 2> /dev/null
