#!/usr/bin/env python

import sys
import os
import subprocess
import whiptail
import time

#Definizioni
TITLE = "V4Vendemmia 0.3-py"   	#Titolo
PASSWORD = "PDP"            	#Password

#Controllo presenza DIR
try:
    dirname=sys.argv[1]
except IndexError:
    sys.exit("Errore!\nMi serve una DIR con le ISO!")

V4VPATH = os.path.abspath(os.path.dirname(__file__)) 		#Cartella V4V
olddev= ''
exit = False

# Setting up things
def setup():
    global olddev
    print(TITLE + "\nInitialization . . .")
    if not os.geteuid() == 0:
        sys.exit("Errore!\nHo bisogno dei permessi di ROOT!")

    #Dev non scrivibili
    w = whiptail.Whiptail("Attenzione!", TITLE, 8, 70)
    w.alert("Assicurati di NON aver inserito la chiavetta su cui vuoi che gli utenti scrivano i sistemi operativi!")   
    olddev = subprocess.check_output("lsblk -d -n -o NAME", shell=True).split('\n') 

#Funzione scelta iso
def isochoice():
    isos = [ iso for iso in os.listdir(dirname) if iso.endswith('.iso') ]
    items = []
    choice = []
    isofile = ''

    #Costruisco lista iso da visualizzare e calcolo dimesione
    for i, iso in enumerate(isos, start=1):
        size = round(os.path.getsize(os.path.join(dirname,iso))/(1024*1024*1024.0),1)
        items.append((iso, str(size)+"GB", "OFF")),size

    try:
        #Controllo se ci sono delle iso
        if not items:
            w = whiptail.Whiptail("Errore!", TITLE, 8, 50)
            w.alert("Nessuna ISO trovata!\nAssicurati che la directory sia giusta.")
            raise SystemExit

        while not choice:
            w = whiptail.Whiptail("Scelta Iso", TITLE, 20, 60)
            choice = w.radiolist("Scegli il sistema da portarti a casa:" , items=items, prefix="     ")
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
            if w.confirm("Inserisci la tua chiavetta USB! \n\nATTENZIONE il contenuto verra' cancellato!"):
                dev = subprocess.check_output("lsblk -d -n -o NAME", shell=True).split('\n')
                mydev = set(dev) - set(olddev)
            else:
                raise SystemExit 

        rv =  mydev.pop()
        if mydev:
            w = whiptail.Whiptail("Attenzione!", TITLE, 10, 50)
            w.alert("Ho notato che hai inserito piu' di una chiavetta!\nRimuovi l'ultima che hai inserito e premi OK.")
    except SystemExit as e:
        if e.code == 1:
            pass
    return rv

# Funzione USB
def usbwrite():
    isofile = isochoice()
    if not isofile:
	    return

    device = usbdevice()
    if not device:
	    return

    #Scrivo la iso
    cmd = '(pv -n "{}" | /bin/dd of="/dev/{}") 2>&1'.format(isofile, device)
    cmd2 = 'whiptail --backtitle "{}" --gauge "Please wait..." 7 100 0'.format(TITLE)
    subprocess.call("{} | {}".format(cmd, cmd2), shell=True)

    #Finito!
    w = whiptail.Whiptail("Finito!", TITLE, 10, 60)
    w.alert("Fatto tutto.\nGoditi la tua {}!".format(isofile))

    #Scrivo nel file log
    f = open("v4vendemmia.log", mode='a')    #Open it
    f.write(isofile + " " + time.asctime() + "\n")
    f.close()


# Funzione DVD
def dvdwrite():
    print("scrivo su DVD: da implementare in futuro")
    pass


###Main###
setup()
while not exit:
    # Imposto Contatore (Controlla se il file esiste e in caso lo crea)
    if os.path.exists("v4vendemmia.log"):
        f = open("v4vendemmia.log", mode='r+')    #Open it
    else:
        f = open("v4vendemmia.log", mode='w+')    #Create it
    cont = len(f.readlines())
    f.close()

    choice = None

    try:
        w = whiptail.Whiptail("Menu Principale", TITLE, 20, 78)
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
            try:
                w1 = whiptail.Whiptail("Password", TITLE, 8, 78)
                passwd = w1.prompt("Digita la password per uscire.", password=True)
                if passwd == PASSWORD:
                    exit = True
            except SystemExit as e:
                if e.code == 1:
                    pass

    if choice == "1":
        usbwrite()
    elif choice == "2":
        dvdwrite()
    elif choice == "3":
        w = whiptail.Whiptail("About us", TITLE, 12, 60)
        w.alert("PDP Free Software User Group <info@pdp.linux.it>\n\nTributo al admstaff diretto da Renzo Davoli\n\nLicense: GNU Affero GPLv3")
    elif choice == "4":
        w = whiptail.Whiptail("Need some help?", TITLE, 10, 30)
        w.alert("Usa:\nFrecce	 Spostarti\nSpazio	 Selezionare\nInvio	  Confermare")
