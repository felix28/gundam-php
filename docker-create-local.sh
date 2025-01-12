cp .env.local .env
sudo rm -r vendor
composer install
sudo chown -R $USER:$USER .

php artisan --version
php artisan key:generate
php artisan config:cache
# rm public/storage
php artisan storage:link
php artisan config:clear
php artisan test
php artisan migrate:refresh
php artisan db:seed --class=UserSeeder
# php artisan passport:install
php artisan cache:clear
sudo chmod -R 777 storage/