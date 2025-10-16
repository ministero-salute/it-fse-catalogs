# it-fse-catalogs

## ATTENZIONE

        Il repository è in fase di riorganizzazione e in un prossimo periodo sarà soggetto ad interventi di razionalizzazione.

Questo repository contiene i:

* [dizionari](terminology/)
* i file [schematron](schematron/)
* i file [xsd](schema/) 

utilizzati in fase di verifica dei CDA2 dal gateway FSE2.0.

Sono inoltre disponibili i [mapping](transform/) in FHIR mapping language per la trasformazione dei CDA2 in bundle FHIR.

## Container

All'interno della directory container è presente un `Dockerfile` che permette di creare un'immagine mongodb con i dizionari precaricati.  
Per la creazione dell'immagine è sufficiente (dalla directory principale del repository) eseguire:
```bash
docker build  . -f container/Dockerfile -t it-fse-catalogs
```

al termine del processo di build sarà possibile lanciare il container con il comando:

```bash
docker run --rm -ti -p 27888:27017 it-fse-catalogs
```

Su `localhost:27888` sarà disponibile un mongodb con credenziali di default (username:`mongoadmin` password:`secret`) contenente un database `fse` con i dati precaricati.

## Repos
- [*it-fse-support*](https://github.com/ministero-salute/it-fse-support) - Pagina di supporto FSE 2.0
- [*it-fse-landing*](https://github.com/ministero-salute/it-fse-landing) - Landing page dei repository FSE 2.0
