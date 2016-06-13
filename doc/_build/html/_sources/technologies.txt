Cosa abbiamo usato?
===================

HTML
----
L'HTML (HyperText Markup Language) è il linguaggio di markup usato per la formattazione e l'impaginazione di documenti ipertestuali.
Un linguaggio di markup, serve appunto a marcare le parti del testo in modo che chi le legge possa interpretarle e nel caso del browser crearci un layout di un certo tipo attraverso i vari tag come quello del titolo::
 
    <h1>Titolo</h1>

o quello del paragrafo::

    <p>Paragrafo</p>

L'HTML è la basa di quasi la totalità dei siti web.

Javascript
----------
Il JavaScript è un linguaggio di scripting lato-client che serve a creare interrazione tra l'utente e la pagina tramite oggetti e eventi.
Le funzioni di script vengo invocate dagli eventi innescati dall'utente sulla pagina web (mouse, tastiera, caricamento della pagina ecc...).

jQuery
^^^^^^
jQuery è una libreria JavaScript per applicazioni web e nasce con l'obiettivo di semplificare la selezione, la manipolazione, la gestione degli eventi e l'animazione delle pagine HTML.

Ecco un esempio di codice che cambia il colore dello sfondo:

**jQuery**::

    $('body').css('background', '#ccc');

**Javascript**::

    function changeBackground(color) {
        document.body.style.background = color;
    }

    onload="changeBackground('red');"

Il codice risulta molto più semplice e immediato, infatti il motto degli sviluppatori jQuery è proprio «write less, do more.».
 
Un'altro importante aspetto della libreria jQuery è quella di implementare la tecnologia AJAX.

CSS
---
Il CSS (Cascading Style Sheets) è un linguaggio usato per definire la formattazione di documenti HTML.
L'uso dei CSS permette di seprare la parte grafica di un sito dalla parte dei contentuti, permettendo una programmazione più chiara e facile da utilizzare, sia per gli autori delle pagine stesse sia per gli utenti, garantendo contemporaneamente anche il riutilizzo di codice ed una sua più facile manutenzione.

PHP
---
PHP (acronimo ricorsivo di "PHP: Hypertext Preprocessor") è un linguaggio di scripting lato-server che permette di creare pagine web dinamiche.
I file php sono composti da parti di html e blocchi di codice php che verranno eseguiti e interpretati sul server prima di essere restituiti, permettendo cosi di creare la pagina in modo dinamico in base alle necessità e alle situazioni.

Apache
------
Apache è forse il più famoso e anche il più utilizzato dei webserver nel mondo.
Un webserver è un applicazione che si occupa di prendere le varie richieste dei client e restituire le relative pagine web.

AJAX
----
AJAX (Asynchronous JavaScript and XML) è una tecnica di sviluppo software per la realizzazione di applicazioni web interattive.
Questa tecnica si basa su uno scambio di dati in background fra web browser e server, che consente l'aggiornamento dinamico di una pagina web senza esplicito ricaricamento da parte dell'utente.
AJAX è asincrono nel senso che i dati extra sono richiesti al server e caricati in background senza interferire con il comportamento della pagina esistente.

XML
---
XML (eXtensible Markup Language) è linguaggio marcatore (Markup Language) estendibile (eXtensible) in quanto permette di creare tag personalizzati, proprio come quelli html, e dare a ciascuno un significato riferito ai contentuti.
Questo permette di creare una struttra di dati in un semplice file di testo, facilitando molto la lettura dei dati.

Bootstrap
---------
Bootstrap è una raccolta di strumenti liberi per la creazione di siti e applicazioni per il Web. Essa contiene modelli di progettazione basati su HTML e CSS, sia per la tipografia, che per le varie componenti dell'interfaccia, come moduli, pulsanti e navigazione.

Dalla versione 2.0 supporta anche il responsive web design. Ciò significa che il layout delle pagine web si regola dinamicamente, tenendo conto delle caratteristiche del dispositivo utilizzato, sia esso desktop, tablet o telefono cellulare. A partire dalla versione 3.0, Bootstrap ha adottato il responsive design come impostazione predefinita, sottolineando il suo essere nata come libreria multidispositivo e multipiattaforma.

