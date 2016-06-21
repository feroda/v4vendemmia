Il Progetto: Considerazioni
===========================
In questa sezione vengono fornite le informazioni riguardo vari problemi emersi durante la realizzazione e le loro soluzioni.

Permessi GNU/Linux
------------------

Generalità
^^^^^^^^^^
Nell'ambito di un sistema GNU/Linux tutto è un file, compresi i file speciali che designano i dispositivi. Linux divide i file in diverse categorie:

    * Directory
    * File regolari (programmi, file di configurazione, file di dati, ecc ..)
    * File speciale (carattere o tipo di blocco) 

Il file system per GNU/Linux è organizzato in un albero, non c'è bisogno di menzionare il nome del disco o la partizione per accedere.

I Permessi
^^^^^^^^^^
In un sistema GNU/Linux, ad ogni file vengono assegnati i permessi per 3 identità:

    * Il proprietario - è l'utente che ha creato il file o l'utente che root ha designato come proprietario
    * Il gruppo (non necessariamente il gruppo del proprietario)
    * Gli altri (quelli che non fanno parte del gruppo)

Per ogni identità (vedi sopra), sono 3 i permessi di accesso:

    * r - read (permesso di lettura)
    * w - write (permesso di scrittura)
    * x - execute (permesso di esecuzione)

La visualizzazione dei permessi viene rappresentata da una stringa di 9 caratteri, preceduta da un carattere che rappresenta il tipo di file.

Questi 9 caratteri, raggruppati per 3 (rwx rwx rwx) definiscono i permessi delle 3 identità (proprietario, gruppo e altri).

Esempio::

    -rwxr-x---  USER    GROUP

Significa:
    * si tratta di un file regolare ( il primo carattere è un trattino -)
    * il proprietario ha tutti i permessi (Read-Write-Execute quindi Leggere-Scrivere-Eseguire)
    * i membri del gruppo hanno i permessi di leggere (il 1° carattere è r) e di eseguire (il 3° carattere è x), invece non hanno il permesso de scrivere (il 2° carattere è un trattino -)
    * gli altri non hanno nessun permesso, ne leggere, ne scrivere, ne eseguire (i 3 caratteri sono dei trattini -)

------------------
Per effettuare una scrittura di una ISO su un dispostivo bisogna appartenere a un gruppo speciale chiamato 'disk'. Di default solo l'utente ROOT appartiene al quel gruppo.

Apache ha un utente tutto suo chiamato 'HTTP' e per questo bisogna aggiungere questo utente al gruppo 'disk' cosi da avere i permessi di scrivere.

Questa soluzione semplice e funzionante non è il massimo per la sicurezza del webserver. Se si ha qualche problema di sicurezza e un terzo riesce a caricare uno script, avrebbe i permessi di scrivere su ogni disco, anche quello dove si trova il sistema.

Client-server
-------------
Anche se la webapp è accessibile remotamente il server può scrivere solo su una chiavetta inserita fisicamente nella macchina. Questo permette l'uso della webapp solo su un singolo computer.

|local-client-server|

Ma si posso sviluppare soluzioni interessanti con minimo sforzo. 

Si può fare in modo che gli utenti danno la loro chiavetta a un responsabile che la inserisce sul server e poi da un computer locale scelgono la distro che vogliono. Questo è facilmente realizzabile in un luogo come la biblioteca dotata di una sala pc.

Un altro può essere di proporre la funzione di base sul server e una funzione di download delle distro ai client remoti.
Oppure usare la parte dei client come un semplice catalogo.

Le possibilità sono tante e ognuno può adattarlo alle sue esigenze.

SQLite
------
Come alternativa per conservare i dati avevo pensato a un database, più precisamente un SQLite.

SQLite è una libreria software scritta in linguaggio C che implementa un DBMS SQLite incorporabile all'interno di applicazioni. 
Permette di creare una base di dati (comprese tabelle, query, form, report) incorporata in un unico file, togliendo la necessità di altri programmi.  
Ha avuto il maggior sviluppo nel mondo mobile, dove un app non può appoggiarsi ad altre e contiene una quantità limitata di dati. 

Ma per V4V ho scelto l'XML non avendo bisogno di gestire grandi quantità di dati ne di fare query complesse, ma di un modo veloce per caricare tutti i dati al primo caricamento della pagina e lasciarli nella cache.

.. |local-client-server| image:: /images/local-client-server.png
