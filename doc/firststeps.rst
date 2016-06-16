Primi passi
===========
Come primo passo abbiamo scritto su un foglio di carta la logica e l'algoritmo di base. Succesivamente avevamo bisogno di un linguaggio.

Abbiamo scelto il Bash [1]_,un linguaggio di scripting semplice ma molto usato tra i sistemisti GNU/Linux per la sua versatilità e la sua integrazione nel sistemi UNIX e GNU/Linux. Visto che un script Bash gira solo su un terminale, l'interfaccia è molto rudimentale. Per dargli un aspetto che potesse attirare l'occhio del utente abbiamo usato whiptail, un tool che permette di creare delle dialog molto semplici ma chiare.

|v4v-bash|

Dopo un paio di giorni di testing abbiamo visto che non c'erano problemi quindi abbiamo deciso di allestire una postazione V4V nella nostra biblioteca cosi che tutti gli utenti potessero usufruirne.

Successivamente abbiamo deciso di provare a riscriverlo con altro linguaggio. Abbiamo deciso di usare il Python [2]_ visto che molti di noi non hanno mai avuto la possibilità di usarlo ma volevano impararlo. Python è un linguaggio di programmazione molto popolare per la sua semplicità e potenza.

E' un linguaggio spesso consigliato ai neo-programmatori per la sua chiarezza, infatti python è stato ideato con l'obbiettivo della leggibilità. Persino un indentazione sbagliata viene considerata un errore.

Il risultato di questa versione a livello visivo era lo stesso avendo usato sempre whiptail per gestire le dialog. Anche l'algormitmo è rimasto lo stesso, proprio per far vedere come il linguaggio sia indipendente dal algoritmo.


.. [1] https://www.gnu.org/software/bash/

.. [2] https://docs.python.org/2/reference/


Dettagli tecnici
----------------
L'applicazione in se, inidpendentemente dal linguaggio, si occupa di capire su quali device non deve scrivere (dischi fissi e altre periferiche già inserite) e successivamente cercare in una directory specificata le ISO delle distro e farle vedere al utente.
Una volta selezionata chiede al utente di inserire una pendrive dove sarà copiata la ISO.
Questa copia, fatta bit a bit, crea un immagine avviabile dal bios.

Cos'è una ISO?
^^^^^^^^^^^^^^
Una ISO è una estensione utilizzata per i file immagine che contiene i dati, nella loro struttura tipica, di un dispositivo o supporto di memorizzazione dati, come ad esempio un hard disk fisso o esterno, un CD/DVD, una chiavetta USB, una scheda di memoria e così via.

Uno dei più popolari e comuni tipi di immagini disco è l'immagine di un CD/DVD. Un'immagine di un CD/DVD è un'esatta copia digitale dello stesso, tramite la quale tutti i dati del supporto ottico vengono salvati in un file che al suo interno ricalca esattamente la struttura e le informazioni di integrità dei dati presenti sul supporto.

.. |v4v-bash| image:: /images/v4v-bash.png
