FROM python:3.9-slim

WORKDIR /app

COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get -y upgrade && apt-get install -y curl iputils-ping net-tools dnsutils&& apt-get clean

EXPOSE 5001

ENV WORKER_SERVICE_NAME=TBD

CMD ["python", "web-service.py"]