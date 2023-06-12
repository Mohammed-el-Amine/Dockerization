# Dockerization
first time using docker, create 3 containers : 1. for database, 2.for miccroservice, 3. for config

##MYSQL##

creation du container mysql avec la commande :  sudo docker run -d --name NOM_CONTAINER -p 3306:3306 -e MYSQL_ROOT_PASSWORD=CHANGE_PASSWORD -v NOM_CONTAINER_SAUVEGARDE:/var/lib/mysql mysql:latest

option -v sert a cree et monter le volume pour une persistence de données : verification avec la commande => sudo docker restart NOM_DU_CONTAINER

mysql:latest sert a obtenir la derniere version de mysql

-p permet de lancer sur un port specifier

l'inspection des données se fait avec la commande : sudo docker volume inspect mysql_data

lancer mysql du container :  sudo docker exec -it CONTAINER_NAME mysql -u root -p

cree le fichier docker-compose.yml et mettre la configuration de php de mysql et des nginx

sudo docker-compose up -d

Cela va créer et démarrer les conteneurs définis dans le fichier docker-compose.yml. L'option -d permet de lancer les conteneurs en arrière-plan.

sudo docker-compose down permet de stop les process
