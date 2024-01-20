#  MedShakeEHR LAMP docker-compose stack

Pile LAMP pour MedShakeEHR en local :
* PHP
* Apache
* MySQL
* phpMyAdmin
* Orthanc
* Reverse proxy
* Certificat SSL autosigné
* VPN (Wireguard)

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```.
* Configurez le .env selon vos besoins.

```bash
cd MedShakeEHR-docker-compose/
cp sample.env .env
nano .env
```
* * Modifiez l'image msehr de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    image: marsante/msehrtest:8.0.6

```

* Ou modifiez l'image docker-compose avec le Dockerfile de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    build: ./7.3.1

```

* Vous pouvez aussi modifier le Dockerfile avec votre clone de MedShakeEHR pour tester vos nouvelles fonctionnalités.
* Puis lancez le docker-compose ```sudo docker-compose up --build -d``` ou ```docker-compose up --build -d``` ou ```sudo docker compose up --build -d``` ou ```docker compose up --build -d``` suivant votre configuration.
* Tapez [msehr.localhost/install.php](msehr.localhost/install.php) dans votre navigateur.
* Suivez les instructions.

* Pour ajouter un module, ou le mettre à jour :

```bash
docker exec -ti msehr php /usr/local/bin/msehr.upgrade.php base
```

* les arguments disponibles sont :  base, chiro, gyneco, general, thermal, mpr, osteo


## Orthanc
* Décommentez le network orthanc (en global et dans le service msehr) et le service orthanc
* Créez le fichier de configuration `cp sample-orthanc.json orthanc.json` et éditez `nano orthanc.json`
* Relancez la stack docker compose comme vu précédemment.

## phpMyAdmin
* Décommentez la stack puis rendez-vous sur [pma.msehr.localhost/](pma.msehr.localhost/)

## VPN (Wireguard)
* Décommentez le service, modifiez le .env en personnalisant avec vos données réseaux / domaine.
* Relancez la stack docker compose comme vu précédemment.

