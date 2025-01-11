# Load the environment variables from the .env file
source gundam-laravel/.env

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com
docker build -t 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-laravel:latest .
docker build -t 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-laravel:universal-century .

echo "APP_NAME=$APP_NAME"
echo "APP_ENV=$APP_ENV"
echo "APP_KEY=$APP_KEY"
echo "APP_URL=$APP_URL"

docker run -d \
  --name gundam-laravel-container \
  -p 9000:9000 \
  -e APP_NAME=$APP_NAME \
  -e APP_ENV=$APP_ENV \
  -e APP_KEY=$APP_KEY \
  -e APP_URL=$APP_URL \
  -e APP_DEBUG=$APP_DEBUG \
  -e QUEUE_CONNECTION=sync \
  -e CACHE_DRIVER=file \
  -e SESSION_DRIVER=file \
  -v webroot:/var/www/html/public \
  felix28/gundam-laravel:version1

#docker run -d \
#  --name laravel-container \
#  -v webroot:/var/www/html/public \
#  my-laravel-image

#-e DB_CONNECTION=$DB_CONNECTION \  
#-e DB_HOST=$DB_HOST \
#-e DB_PORT=$DB_PORT \
#-e DB_DATABASE=$DB_DATABASE \
#-e DB_USERNAME=$DB_USERNAME \
#-e DB_PASSWORD=$DB_PASSWORD \