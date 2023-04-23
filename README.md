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
    image: marsante/msehrtest:7.3.1

```

* Ou modifiez l'image docker-compose avec le Dockerfile de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    build: ./7.3.1

```

* Vous pouvez aussi modifier le Dockerfile avec votre clone de MedShakeEHR pour tester vos nouvelles fonctionnalités.
* Créez le réseau externe proxy ```docker network create proxy``` ou ```docker network create proxy``` suivant votre configuration.
* Puis lancez le docker-compose ```sudo docker-compose up --build -d``` ou ```docker-compose up --build -d``` ou ```sudo docker compose up --build -d``` ou ```docker compose up --build -d``` suivant votre configuration.
* Tapez [msehr.localhost/install.php](msehr.localhost/install.php) dans votre navigateur.
* Suivez les instructions.

Le projet actuel propose par défaut une persistance de la base de donnée, mais pas de l'installation des modules (il faudra glisser à nouveau le zip à chaque redémarrage du conteneur) et des fichiers personnalisés. Il faudra adapter les volumes que vous souhaitez conserver (les mettre à jour par les zips) et les volumes que vous voulez mettre à jour par le conteneur docker.

## Orthanc
* Décommentez le network orthanc (en global et dans le service msehr) et le service orthanc
* Créez le fichier de configuration `cp sample-orthanc.json orthanc.json` et éditez `nano orthanc.json`
* Relancez la stack docker compose comme vu précédemment.

## phpMyAdmin
* Décommentez la stack puis rendez-vous sur [pma.msehr.localhost/install.php](pma.msehr.localhost/install.php)

## VPN (Wireguard)
* Décommentez le service, modifiez le .env en personnalisant avec vos données réseaux / domaine.
* Relancez la stack docker compose comme vu précédemment.

