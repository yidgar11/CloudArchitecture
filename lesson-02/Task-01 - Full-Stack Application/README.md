# preparations 
`alias k="kubectl"`

`export NS1="fullstack-app"`

## Steps 
### 1. Create a namespace called `fullstack-app` to isolate the resources.
`k create ns fullstack-app`

### 2. Set a resource quota for the namespace to limit resource usage.
`k apply -f namespace/resource-quota.yaml`

Note: When creating resource quota , need to define resources (request and limit) in the deployments  

### 3. Deploy a MySQL Database
Create a Secret for the MySQL root password and a ConfigMap for database configuration.
#### Create a Secret for the MySQL root password.

decode mypassword nd add to the secretdile 

`echo -n mypassword | base64`
![img.png](img.png)

#### Create a ConfigMap for MySQL database configuration.

#### Deploy MySQL with the created Secret and ConfigMap.
`k apply -f secrets/secret-02.yaml`

`k apply -f configuration/configmap-02.yaml`

`k apply -f services/mysql-deployment.yaml`


#### Check db is working 

`k exec -it pod/mysql-66dc58fdd5-bgzw5 -n $NS1 -- /bin/bash`
and run 

`mysql -p   (password = 'password')`

`show databases;`

#### Create the Backend image 

`docker login -u yidgar11`

`docker build -t yidgar11/my-backend:1.0`

`docker push yidgar11/my-backend:1.0`

#### Use it in the Backend-deployment.yaml and apply

`k apply -f services/backend-deployment.yaml`






# Wrap all up 
## Create
`k apply -f namespace/resource-quota.yaml`

`k apply -f secrets/secret-02.yaml`

`k apply -f configuration/configmap-02.yaml`

`k apply -f storage/mysql-storage.yaml`

`k apply -f services/mysql-deployment.yaml`

`k apply -f services/backend-deployment.yaml`



# Delete 

`k delete -f services/mysql-deployment.yaml`

`k delete -f storage/mysql-storage.yaml`

`k delete -f configuration/configmap-02.yaml`

`k delete -f secrets/secret-02.yaml`

`k delete -f namespace/resource-quota.yaml`

`k delete -f services/backend-deployment.yaml`