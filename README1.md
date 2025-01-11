## Docker (Build and push images)

### Prerequisites
```
Minikube
```

### Background
By using Docker in development environment with programmers using different local machines (Windows, Linux and Mac), we are sure what works on me should work on you. What don't work on me should don't work on you as well. This page will teach you how to build a Docker Image within Minikube and how to push an image to Amazon ECR.

### Build Docker Image within Minikube
1. Clone the Laravel repository and install its dependencies:
```
	git clone https://github.com/learnk8s/laravel-kubernetes-demo.git
```
2. Before you can test the Docker image, you will need to build it:
```
cd /to/your/project/directory 
docker build -t john-doe/laravel-kubernetes-demo:sour-cream .
```
- **-t** - This is the tag of Docker image.
- **john-doe/laravel-kubernetes-demo:sour-cream** - This is the format for naming a Docker Image. Before / sign is your username. You can put your real Docker Hub username if you want to push this Docker Image to your Docker Hub account. After / sign is the descriptive name we give to our container. After : sign is the version name or number. E.g., you can put 1.0.0 or class-s for your version. If you don't put : sign, the default version will be named as "latest".
- **.** - Tells us the file named Dockerfile is within this directory.

After running the command above, you must see "Successfully built" and "Successfully tagged" below your terminal.

3. We will now run the app. Inside your project directory folder, create a file named run-docker-image.sh then copy-paste the command below (You can also copy-paste this command in your terminal if you don't want to create a Shell Script):

```
docker run -ti \ 
  -p 8080:80 \ 
  -e APP_KEY=base64:cUPmwHx4LXa4Z25HhzFiWCf7TlQmSqnt98pnuiHmzgY= \     
  laravel-kubernetes-demo
```
```
sudo chmod +x run-docker-image.sh
./run-docker-image.sh
```
You must be able to see the app by visiting <a href="localhost:8080" target="_blank">localhost:8080</a>.
Feel free to change port 8080 into your available port number.
 
4. Since we verify that we can build the Docker Image and run our app, the next step is to build the image within Minikube. Run the command below:

```
cd /to/your/project/directory
eval $(minikube docker-env)
docker build -t john-doe/laravel-kubernetes-demo:sour-cream .
```

<strong>IMPORTANT:</strong>Don’t forget to execute the `eval $(minikube docker-env)`. Building the image inside Minikube is necessary. You should run the command only once in the current terminal.

5. Before deployment, make sure the current cluster is Minikube. Not staging and a big no to production cluster as well! Run this command to set our current cluster to Minikube:
```
minikube start
```
6. Now that the app’s image is built and available inside Minikube, go ahead with deploying it. Create a file named deploy-docker-image.sh then copy-paste the command below (You can also copy-paste this command in your terminal if you don't want to create a Shell Script):

```
kubectl run laravel-kubernetes-demo \ 
  --image=john-doe/laravel-kubernetes-demo:sour-cream \ 
  --port=80 \ 
  --image-pull-policy=IfNotPresent \ 
  --env=APP_KEY=base64:cUPmwHx4LXa4Z25HhzFiWCf7TlQmSqnt98pnuiHmzgY=
```
- **laravel-kubernetes-demo** - The pod name.
- **image-pull-policy=IfNotPresent** - We will only pull the image if it does not exists. Since we build it inside Minikube (thus making it exists), no pulling of image from Docker Hub will happen. 
```
sudo chmod +x deploy-docker-image.sh
./deploy-docker-image.sh
```

To check if the STATUS of the pod is Running, run `kubectl get pods`

You can also open a new terminal then run `minikube dashboard`. If the color of the pod is green, then your deployment is successful.

7. A pod running in a cluster has a dynamic IP. To avoid managing IP addresses manually, you need to use a Service. So even if the IP address of a Pod changes, the service is always pointing to it. Run the command below to create a service:
```
kubectl expose pods laravel-kubernetes-demo --type=NodePort --port=80
```
It should show `service/laravel-kubernetes-demo exposed`.

You can also verify that the Service was created successfully with:
```
kubectl get services
```
To get the URL of the service type `minikube service --url=true laravel-kubernetes-demo` then visit it using your browser.

Congrats! You now have a movie trailer of your app before viewing it in real Kubernetes.

### Push Docker Image to Amazon ECR
1. Open the Amazon ECR console at <a href="https://console.aws.amazon.com/ecr/repositories" target="_blank">https://console.aws.amazon.com/ecr/repositories</a>.

2. In the navigation pane, choose Repositories.

3. On the Repositories page, choose Create repository.

4. For Repository name, enter a unique name for your repository (e.g. `laravel-kubernetes-demo`).

5. Click Create Repository button.

6. In Terminal, go to your project directory then run these:
```
cd project/dir
minikube start
eval $(minikube docker-env)
```
Remember `eval $(minikube docker-env)` should only run once.

7. Build image with a format similar like this:
```
docker build -t 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-laravel:universal-century .
```
8. Log-in to ECR:
```
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com
``` 
You must see `Login Succeeded` in Terminal.

9. Push image to ECR:
```
docker push 221082179682.dkr.ecr.ap-southeast-1.amazonaws.com/gundam-laravel:universal-century
```

### Pull Docker Image from Amazon ECR
1. Check if image exists:
```
docker images
```
2. Pull then check if image now exists:
```
docker pull 105618632367.dkr.ecr.us-east-1.amazonaws.com/laravel-kubernetes-demo:sour-cream
docker images
```

### Important
```
Whenever we want to launch an image on minikube, we will need to build it in the appropriate docker environment. To use it, we can use this command.
```
```
eval $(minikube docker-env)
```
```
After switching your docker context to that of Minikube, you must authenticate your minikube docker instance to be able to pull images directly from our staging ECR respositories. After ensuring your current shell environment is making use of your staging AWS credentials, this can be accomplished with the following command.
```
```
eval $(aws ecr get-login --no-include-email --region us-east-1)
```
```
For example, once in this environment, the base airflow image can be pulled from staging using:
```
```
docker pull 105618632367.dkr.ecr.us-east-1.amazonaws.com/airflow-base:latest
docker tag 105618632367.dkr.ecr.us-east-1.amazonaws.com/airflow-base:latest airflow-base:latest
```