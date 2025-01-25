# Start the docker image 
docker run -d --name trivy-test trivy-scan:1.0

# Login to the container and run scan  
docker exec -it trivy-test /bin/bash

7ce168d9330a:/# trivy image nginx:alpine 

![img.png](img.png)