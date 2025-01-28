# preparations 
`alias k="kubectl"`

`export NS2="multi-tier-app"`

## Steps 
### 1. Create a namespace called `multi-tier-app` to isolate the resources.

`k cretae multi-tier-app`

### 2. Set a resource quota for the namespace to limit resource usage.
`k apply -f namespace/resource-quota.yaml`
![img.png](img.png)

### 3. Deploy a Redis Cache
#### 3.1 Create a ConfigMap for Redis configuration.
`k apply -f configuration/configmap-redis.yaml`
![img_1.png](img_1.png)

Deploy Redis with the created ConfigMap.
`k apply -f deployments/redis-deployment.yaml`
![img_2.png](img_2.png)

#### login to the pod to check redis is working
`exec -it pod/redis-dcc5d694b-zsfqx -n $NS2 -- /bin/bash`
![img_3.png](img_3.png)

### 4. Deploy a Backend Server
#### Deploy the backend server with environment variables configured to connect to the Redis cache.

#### Ensure the backend server has two replicas.