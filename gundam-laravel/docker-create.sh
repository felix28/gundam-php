sudo rm -r vendor
docker image prune -f
docker run --rm -v $(pwd):/app composer install
sudo chown -R $USER:$USER .
docker-compose -f docker-compose.yml up -d --build
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan --version
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan key:generate
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan config:cache
docker-compose -f docker-compose.yml exec gundam-dev-app rm public/storage
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan storage:link
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan config:clear
#docker-compose -f docker-compose.yml exec gundam-dev-app vendor/bin/phpunit
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan migrate:refresh
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan db:seed
#docker-compose -f docker-compose.yml exec gundam-dev-app php artisan passport:install
docker-compose -f docker-compose.yml exec gundam-dev-app php artisan cache:clear
chmod -R 777 storage/
docker ps -a