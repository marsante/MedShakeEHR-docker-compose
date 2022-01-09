#  MedshakeEHR LAMP docker-compose stack

Pile LAMP pour MedshakeEHR en local
* PHP
* Apache
* MySQL
* Composer
* phpMyAdmin
* Orthanc
* Certificat ssl autosigné

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```
* Configurez .env selon vos besoin 

```bash
cd MedShakeEHR-dockerCompose/
cp sample.env .env
nano .env
```
* Lancez une première fois le script shell ``` init.sh ```
* Tapez medshakeehr.localhost dans votre navigateur
* Suivez l'installation
* Pour le moment, il faut modifier manuellement le protocole dans le config.yaml. Changez `http` par `https`
