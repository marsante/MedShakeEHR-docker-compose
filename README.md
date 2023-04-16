#  MedShakeEHR LAMP docker-compose stack

Pile LAMP pour MedShakeEHR en local :
* PHP
* Apache
* MySQL
* Orthanc
* Certificat SSL autosigné

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```.
* Configurez .env selon vos besoins.

```bash
cd MedShakeEHR-docker-compose/
cp sample.env .env
nano .env
```
* * Modifier l'image msehr de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    image: marsante/msehrtest:7.3.1

```

* Ou modifier l'image docker-compose avec le Dockerfile de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    build: ./7.3.1

```

* Vous pouvez aussi modifier le Dockerfile avec votre clone de MedShakeEHR pour tester vos nouvelles fonctionnalités.
* Créez le réseau externe proxy ```docker network create proxy``` ou ```docker network create proxy``` suivant votre configuration.
* Puis lancez le docker-compose ```sudo docker-compose up --build -d``` ou ```docker-compose up --build -d``` ou ```sudo docker compose up --build -d``` ou ```docker compose up --build -d``` suivant votre configuration.
* Tapez [medshakeehr.localhost/install.php](medshakeehr.localhost/install.php) dans votre navigateur.
* Suivez les instructions.

Le projet actuel propose par défaut une persistance de la base de donnée, mais pas de l'installation des modules (il faudra glisser à nouveau le zip à chaque redémarrage du conteneur) et des fichiers personnalisés. Il faudra adapter les volumes que vous souhaitez conserver (les mettre à jour par les zips) et les volumes que vous voulez mettre à jour par le conteneur docker.