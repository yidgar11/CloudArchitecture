# preparations 
```sh
alias k="kubectl"
export NS="flask-app"
export region="us-east-1"
export AWS_ID=148761662110
```
## Login to ECR
```shell 
# For PRIVATE
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${AWS_ID}.dkr.ecr.${region}.amazonaws.com

# For PUBLIC 
aws ecr-public get-login-password --region ${region} | docker login --username AWS --password-stdin public.ecr.aws/q2y0f5j6
``` 

## Create PRIVATE OR PUBLIC repository in AWS for the flask-app
```shell
# For PRIVATE
aws ecr create-repository --region ${region} --repository-name cloudexperts/falsk-app

# FOr PUBLIC 
aws ecr-public create-repository --repository-name cloudexperts/flask-app
 
```

# create nginx ingress 
```shell
k create ns ingress-nginx
k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

# Description
TODO - Add schema 




## Build the apps 
1. Build the docker image
```shell
cd flask-application/
# For PRIVATE repo 
docker build -t ${AWS_ID}.dkr.ecr.${region}.amazonaws.com/cloudexperts/falsk-app:1.0 .

# or for PUBLIC Repo
docker build -t  .
```

2. Push the image
```shell
# PRIVATE 
docker push  ${AWS_ID}.dkr.ecr.${region}.amazonaws.com/cloudexperts/falsk-app:1.0

# PUBLIC 
docker push public.ecr.aws/q2y0f5j6/cloudexperts/flask-app:1.0
```

3. Create Secret for pulling the image from ECR 
   and Reference this secret in your Kubernetes deployment configuration

`secret name : lesson4-secret`

```shell
k apply -f namespace/task4-namespace.yaml
kubectl create secret docker-registry lesson4-secret \
  --docker-server=${AWS_ID}.dkr.ecr.${region}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region ${region}) \
  -n $NS
```
Note :  To (manually) pull an image from ECR , use :
```shell
docker pull ${AWS_ID}.dkr.ecr.${region}.amazonaws.com/{repository}/{image_name}:{TAG}
```

# Creation of all resources
```shell
# configs 
k apply -f namespace/task4-namespace.yaml
k apply -f configuration/flask-config.yaml
k apply -f secrets/flask-secret.yaml
# deployments 
k apply -f flask-application/flask-deployment.yaml
```

# Deletion of all resources
```shell
# deployments 
k delete -f flask-application/flask-deployment.yaml

## Configs 
k delete -f namespace/task4-namespace.yaml
k delete -f configuration/flask-config.yaml
k apply -f secrets/flask-secret.yaml

# nginx
k delete ns ingress-nginx 
```

# Check pod and service works with livetest 
```shell
k port-forward pod/flask-app-6c4d799b47-944lz 5000:5000
k port-forward service/flask-service -n $NS 5000:80
```
in both cases , when running below 
```shell
curl localhost:5000/
```
Expected:
![img.png](img.png)
