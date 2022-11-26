#  MedshakeEHR LAMP docker-compose stack

Pile LAMP pour MedshakeEHR en local :
* PHP
* Apache
* MySQL
* Orthanc
* Certificat ssl autosigné

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```.
* Configurez .env selon vos besoins.

```bash
cd MedShakeEHR-docker-compose/
cp sample.env .env
nano .env
```

* Modifier l'image docker-compose avec le dockerfile de votre choix. 

```bash
nano docker-compose.yml
medshakeehr:
    build: ./7.1.1

```

* Vous pouvez aussi modifier le Dockerfile avec votre clone de MedshakeEHR pour tester vos nouvelles fonctionnalités.
* Puis lancez le docker-compose ```sudo docker-compose up --build -d``` ou ```docker-compose up --build -d``` suivant votre configuration.
* Tapez medshakeehr.localhost dans votre navigateur.
* Suivez les instructions.

Le projet actuel propose par défaut une persistance de la base de donnée, mais pas de l'installation des modules (il faudra reglisser le zip à chaque redémarrage du container) et des fichiers personnalisés. Il faudra adapter les volumes que vous souhaitez conserver (les mettre à jour par les zips) et les volumes que vous voulez mettre à jour par le container docker.