cp .env.docker .env
sudo rm -r vendor
docker image prune -f
docker run --rm -v $(pwd):/app composer install
sudo chown -R $USER:$USER .
docker-compose -f docker-compose.yml up -d --build
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan --version
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan key:generate
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan config:cache
#docker-compose -f docker-compose.yml exec gundam-dev-php rm public/storage
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan storage:link
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan config:clear
docker-compose -f docker-compose.yml exec gundam-dev-php vendor/bin/pest
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan migrate:refresh
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan db:seed --class=UserSeeder
#docker-compose -f docker-compose.yml exec gundam-dev-php php artisan passport:install
docker-compose -f docker-compose.yml exec gundam-dev-php php artisan cache:clear
sudo chmod -R 777 storage/
docker ps -a