# Istruzioni per la versione python

- installare modulo whiptail per python con `pip install whiptail`
- eseguire lo script con python2

# COME RIFARLO E CAPIRLO?

consiglio di rifare il processo come quando avevamo scritto `V4V.sh` (stesso programa in Bash)

- partire con un file vuoto e tenere il V4V.py solo come traccia per conoscere python
- preparare le funzioni vuote:
  - isochoice
  - usbdevice
  - usbwrite
  - main
- riempire le funzioni con dati prefissati, ad esempio:
  * `usbdevice` puo' fare "return /dev/sdq1"
  * `isochoice` puo' fare "return linuxmint.iso"
- implementare il main che chiami la `usbwrite`
- realizzare la vera `usbwrite`
- proseguire realizzando le parti che sembrano piu' facili. Ad esempio il menu di scelta che e' gia' fatto nel py

grazie a questo processo si delinea iterativamente il programma e si prende dimestichezza graduale con python,
alleniamo il cervello ad affrontare un problema per volta.

