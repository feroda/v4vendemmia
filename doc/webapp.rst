Il passo successivo: WebApp
===========================
Ma l'interfaccia della versione Bash/Python "spaventava" ancora qualche utente. L'utente vuole qualcosa di bello da vedere e intuitivo da usare.  
Cosi abbiamo cominciato a pensare come risolvere questo problema. Abbiamo pensato a tante soluzioni: interfaccia Qt, programma C# . . .  

Ma alla fine l'idea vincente è stata la WebApp che io ho portato avanti.
Per la realizzazione ho avuto bisogno di approfondire meglio le cose fatte durante l'ultimo anno di scolastico ma anche studiare tecnologie nuove per risolvere i vari problemi nel miglior modo possibile.

Cos'è una WebApp?
-----------------
Una WebApp è un'applicazione accessibile via browser per mezzo di una rete (Intranet, Internet), offrendo determinati servizi all'utente.
Ormai il mondo web e le tecnologie si sono evolute cosi tanto che le interfaccie web posso competere tranquillamente con quelle desktop che per molti anni sono state l'unica scelta degli sviluppatori.

Le applicazioni web solitamente sono una combianazione di script lato-server (ASP, PHP, etc) and script lato-client (HTML, Javascript, etc).
Il lato client si occupa di gestire l'interfaccia mentre il lato server si occupa della gestione dei dati e dalla parte logica.

Le webapp posso offire le stesse funzionalità e dara la possibilità di lavora su più piattaforme diverse. Un esempio può essere Google Docs che permette di avere i documenti sincronizzati tra tutti i dispositivi, indipendentemente dal sistema operativo e senza bisogno di installare nulla.

Questo tipo di applicazioni rappresenta perfettamente l'achitettura client-server dove un server offre dei servizi ai vari client. Il client effettua delle richieste che viaggiano attraverso la rete e arrivano al server che la processa e risponde di conseguenza.

|client-server|

Questo è forse il tipo di architettura più usato, lo stesso internet lavora con questa metodo, dove i browser chiedono ai vari webserver delle pagine web.

.. |client-server| image:: /images/client-server.png
