docker build -t felix28/gundam-nginx:version1 .
docker build -t 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-nginx:latest .
docker push 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-nginx:latest
docker run -d \
  --name gundam-nginx-container \
  -p 9001:80 \
  --volumes-from gundam-laravel-container \
  felix28/gundam-nginx:version1