FROM python:3.9-slim

WORKDIR /app

COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get -y upgrade && apt-get install -y curl iputils-ping net-tools dnsutils && apt-get clean

EXPOSE 5002

ENV WEB_SERVICE_NAME="tbd"


CMD ["python", "worker-service.py"]