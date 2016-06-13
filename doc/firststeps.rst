Primi passi
===========
Per iniziare abbiamo scritto su un foglio di carta la logica di base e abbiamo scelto un linguaggio di scripting semplice, il Bash [1]_, per realizzare il nostro primo Proof of concept.

Dopo un paio di giorni era finito e funzionante, cosi abbiamo subito allestito una postazione nella nostra biblioteca cosi che tutti gli utenti possano usufruirne.

Successivamente abbiamo deciso di provare un altro linguaggio, che alcuni di noi volevamo imparare, cosi abbiamo riscritto V4V in Python [2]_.
Il risultato al livello visivo era lo stesso cosi come l'algormitmo. Cosi abbiamo potuto far vedere come il linguaggio sia indipendente dal algoritmo.


.. [1] https://www.gnu.org/software/bash/

.. [2] https://docs.python.org/2/reference/


Dettagli tecnici
----------------
L'applicazione in se, inidpendentemente dal linguaggio, si occupa di cercare in una directory specificata le ISO e farle vedere al utente.
Una volta selezionata gli viene chiesto di inserire una pendrive dove sarà copiata la ISO.
Questa copia, fatta bit a bit, crea un immagine avviabile dal bios.

Cos'è una ISO?
^^^^^^^^^^^^^^
Una ISO è una estensione utilizzata per i file immagine che contiene i dati, nella loro struttura tipica, di un dispositivo o supporto di memorizzazione dati, come ad esempio un hard disk fisso o esterno, un CD/DVD, una chiavetta USB, una scheda di memoria e così via.

Uno dei più popolari e comuni tipi di immagini disco è l'immagine di un CD/DVD. Un'immagine di un CD/DVD è un'esatta copia digitale dello stesso, tramite la quale tutti i dati del supporto ottico vengono salvati in un file che al suo interno ricalca esattamente la struttura e le informazioni di integrità dei dati presenti sul supporto.
