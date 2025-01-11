docker stop gundam-dev-phpmyadmin
docker stop gundam-dev-mysql
docker stop gundam-dev-php
docker stop gundam-dev-nginx
docker rm gundam-dev-phpmyadmin
docker rm gundam-dev-mysql
docker rm gundam-dev-php
docker rm gundam-dev-nginx
docker image prune -f