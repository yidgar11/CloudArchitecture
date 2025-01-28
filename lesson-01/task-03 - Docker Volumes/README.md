# How to run 

# create volume and inspect it 
docker volume create mydata 
docker volume inspect mydata

# 1. Create local directory for the data 
mkdir ./mysql_data
![img.png](img.png)

## 2. Run the docker compose 
docker-compose up -d
![img_2.png](img_2.png)

## 3. check that the mysql data dir is populated
![img_3.png](img_3.png)

# to clean , run  
docker-compose down --volumes
