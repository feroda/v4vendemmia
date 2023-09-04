#!/usr/bin/env python

import sys
import os
import subprocess
import whiptail
import time
from utils import size_giga, get_devs

# Definizioni
TITLE = "V4Vendemmia 0.3-py"
PASSWORD = b"PDP"

# Controllo presenza DIR
try:
    dirname = sys.argv[1]
except IndexError:
    sys.exit("Errore!\nMi serve una DIR con le ISO!")

# Cartella V4V
V4VPATH = os.path.abspath(os.path.dirname(__file__))
olddev = ''
exit = False


# Setting up things
def setup():
    global olddev
    print(f"{TITLE}\nInitialization...")
    if False:  # not os.geteuid() == 0:
        sys.exit("Errore!\nHo bisogno dei permessi di ROOT!")

    # Dev non scrivibili
    w = whiptail.Whiptail("Attenzione!", TITLE, 8, 70)
    w.alert("Assicurati di NON aver inserito la chiavetta su "
            + "cui vuoi che gli utenti scrivano i sistemi operativi!")
    olddev = get_devs()


# Funzione scelta iso
def isochoice():
    isos = [iso for iso in os.listdir(dirname) if iso.endswith('.iso')]
    items = []
    choice = []
    isofile = ''
    n_length = 0

    # Costruisco lista iso da visualizzare e calcolo dimesione
    for i, iso in enumerate(isos, start=1):
        size = size_giga(os.path.join(dirname, iso))
        items.append((iso, str(size)+"GB", "OFF")), size
        if n_length < len(iso):
            n_length = len(iso)

    try:
        # Controllo se ci sono delle iso
        if not items:
            w = whiptail.Whiptail("Errore!", TITLE, 8, 50)
            w.alert("Nessuna ISO trovata!\n Assicurati\
                    che la directory sia giusta.")
            raise SystemExit

        while not choice:
            w = whiptail.Whiptail("Scelta Iso", TITLE, 20, n_length+25)
            choice = w.radiolist("Scegli il sistema da portarti a casa:",
                                 items=items, prefix="     ")
    except SystemExit as e:
        if e.code == 1:
            pass
    else:
        isofile = os.path.join(dirname, choice[0])
    return isofile


# Funzione Dev dove scrivere
def usbdevice():
    mydev = []
    rv = ''

    try:
        while not mydev:
            w = whiptail.Whiptail("Errore!", TITLE, 10, 50)
            if w.confirm("Inserisci la tua chiavetta USB! \n\n"
                         + "ATTENZIONE il contenuto verra' cancellato!"):
                dev = get_devs()
                mydev = set(dev) - set(olddev)
            else:
                raise SystemExit

        rv = mydev.pop()
        if mydev:
            w = whiptail.Whiptail("Attenzione!", TITLE, 10, 50)
            w.alert("Ho notato che hai inserito piu' di una chiavetta!\n"
                    + "Rimuovi l'ultima che hai inserito e premi OK.")
    except SystemExit as e:
        if e.code == 1:
            pass
    return rv


# Funzione USB
def usbwrite():
    isofile = isochoice()
    if not isofile:
        return None

    device = usbdevice()
    if not device:
        return None

    # Scrivo la iso
    cmd = '(pv -n "{}" | /bin/dd of="/dev/{}") 2>&1'.format(isofile, device)
    cmd2 = 'whiptail --gauge "Please wait..." 7 100 0'
    subprocess.call("{} | {}".format(cmd, cmd2), shell=True)

    # Finito!
    w = whiptail.Whiptail("Finito!", TITLE, 10, 60)
    w.alert("Fatto tutto.\nGoditi la tua {}!".format(isofile))

    # Scrivo nel file log
    f = open("v4vendemmia.log", mode='a')
    f.write(isofile + " " + time.asctime() + "\n")
    f.close()


# Main
setup()
while not exit:
    # Imposto Contatore (Controlla se il file esiste e in caso lo crea)
    if os.path.exists("v4vendemmia.log"):
        # Open it
        f = open("v4vendemmia.log", mode='r+')
    else:
        # Create it
        f = open("v4vendemmia.log", mode='w+')
    cont = len(f.readlines())
    f.close()

    choice = None

    try:
        w = whiptail.Whiptail("Menu Principale", TITLE, 20, 78)
        choice = w.menu("Scegli", items=(
            ("Usa:", ""),
            ("", ""),
            ("Frecce", "Spostarti"),
            ("Spazio", "Selezionare"),
            ("Invio", "Confermare"),
            ("", ""),
            ("[1]", "Installa un sistema libero su USB"),
            ("[2]", "Qualche info su di noi"),
            ("", ""),
            ("", ""),
            ("ISO distribuite finora", str(cont)),
        ), prefix="  ")
    except SystemExit as e:
        if e.code == 1:
            try:
                w1 = whiptail.Whiptail("Password", TITLE, 8, 78)
                passwd = w1.prompt("Digita la password per uscire.",
                                   password=True)
                if passwd == PASSWORD:
                    exit = True
            except SystemExit as e:
                if e.code == 1:
                    pass

    if choice == b"[1]":
        usbwrite()
    elif choice == b"[2]":
        w = whiptail.Whiptail("About us", TITLE, 12, 60)
        w.alert("PDP Free Software User Group <info@pdp.linux.it>\n\n"
                + "Tributo al admstaff diretto da Renzo Davoli\n\n"
                + "License: GNU Affero GPLv3")
