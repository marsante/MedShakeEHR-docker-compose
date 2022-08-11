#  MedshakeEHR LAMP docker-compose stack

Pile LAMP pour MedshakeEHR en local
* PHP
* Apache
* MySQL
* Orthanc
* Certificat ssl autosigné

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```
* Configurez .env selon vos besoins 

```bash
cd MedShakeEHR-dockerCompose/
cp sample.env .env
nano .env
```

* buildez par exemple l'image 7.1.1 :

```bash
cd 7.1.1
docker build --rm --pull -t medshakeehrdocker:7.1.1
cd ..
```

* Modifiez si besoin votre docker-compose.yml
* Puis lancez le docker-compose ```sudo docker-compose up -d``` ou ```docker-compose up -d``` suivant votre configuration.
* Tapez medshakeehr.localhost dans votre navigateur
* Suivez les instructions.

Le projet actuel propose par défaut une persistance de la base de donnée, mais pas de l'installation des modules (il faudra reglisser le zip à chaque redémarrage du container) et des fichiers personnalisée. Il faudra adapter les volumes que vous souhaitez conserver et mettre à jour par les zips et les volumes que vous voulez être mis à jour par le container docker.