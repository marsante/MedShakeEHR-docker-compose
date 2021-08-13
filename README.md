#  MedshakeEHR LAMP docker-compose stack

Pile LAMP pour MedshakeEHR
* PHP
* Apache
* MySQL
* Composer
* phpMyAdmin
* Orthanc

##  Installation
 
* Clonez le projet sur votre ordinateur ```git clone ```
* Configurez .env selon vos besoin 

```bash
cd MedShakeEHR-dockerCompose/
cp sample.env .env
nano .env
```
* Lancez une première fois le script shell ``` docker-compose up --build ```

* Après vous pouvez utiliser les commandes classiques de docker-compose

* Tapez localhost dans votre navigateur
