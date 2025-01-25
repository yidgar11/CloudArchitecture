# 1. Build the image
docker build -t healthcheck:1.0 .

# 2. Run the image 
docker run -it -d --name healthcheck -p 3040:80 healthcheck:1.0

![img_1.png](img_1.png) 

# 3. check the conntainer 
curl localhost:3040

![img.png](img.png)

# and another option - check health using 
 docker inspect --format='{{json .State.Health.Status}}' healthcheck
![img_2.png](img_2.png)