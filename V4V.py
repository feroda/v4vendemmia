#!/usr/bin/env python

import sys
import os
import subprocess

# To use this you must do "pip install whiptail"
import whiptail

#Definizioni
TITLE="V4Vendemmia 0.3-py"    #Titolo
PASSWORD="PDP"                  #Password
LOGFILE="v4vendemmia.log"	#Nome del Log
DIALOG="whiptail"

dirname=sys.argv[1]
V4VPATH=os.path.abspath(os.path.dirname(__file__)) 		#Cartella V4V
exit = False


# Setting up things
def setup():
    print("Inizializzo")
    pass


def isochoice():
    return "unfile.iso senza farlo scegliere all'utente per ora"


def usbdevice():
    return "quella sul tuo PC stai attento che puoi flasharti il disco se il device non e' quello giusto!"


# Funzione USB
def usbwrite():
    isofile = isochoice()
    device = usbdevice()
    cmd = "dd if={} of={}".format(device, isofile)
    print("scrivo con il comando {}".format(cmd))
    # scommenta quando sei sicuro!!!
    subprocess.check_output(cmd, shell=True)
    print("scritto su USB")


# Funzione DVD
def dvdwrite():
    print("scrivo su DVD: da implementare in futuro")
    pass


###Main###

setup()
while not exit:

    # Imposto Contatore
    f = file("{}/V4V/data/{}".format(V4VPATH, LOGFILE))
    cont = len(f.readlines())
    choice = None

    w = whiptail.Whiptail("Menu Principale", TITLE, 20, 78)
    try:
        choice = w.menu("Scegli", items=(
            ("1", "Installa un sistema libero su USB"),
            ("2", "Masterizza un sistema libero su CD/DVD (prossimamente!)"),
            ("3", "Qualche info su di noi"),
            ("4", "Aiuto"),
            ("", ""),
            ("", ""),
            ("", ""),
            (str(cont), "ISO distribuite finora"),
        ), prefix="   ")
    except SystemExit as e:
        if e.code == 1:
            w1 = whiptail.Whiptail("Password", TITLE, 8, 78)
            try:
                passwd = w1.prompt("Digita la password per uscire.", password=True)
            except SystemExit as e:
                pass  # continue
            else:
                # otherwise match security password for public place
                if passwd == PASSWORD:
                    exit = True

    raise ValueError(choice)
    if choice == 1:
        usbwrite()
    elif choice == 2:
        dvdwrite()
    elif choice == 3:
        subprocess.check_output([
            DIALOG, "--title", TITLE,
            "--backtitle", TITLE, "--msgbox",
            file("{}/V4V/data/ABOUT.txt".format(V4VPATH)).read(),
            12, 60]) # 3>&1 1>&2 2>&3
    elif choice == 4:
        print("aiuto")
        # source $V4VPATH/V4V/functions/HelpDialog.sh
