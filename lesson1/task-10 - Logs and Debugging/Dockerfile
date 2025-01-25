FROM python:3.9-slim
LABEL authors="yidgar"
WORKDIR /app
COPY requirements.txt .
RUN pip3 install -r requirements.txt
RUN apt update
RUN apt install curl -y
COPY *.txt .
COPY my-flask-app.py .
COPY template/ ./templates/

ENTRYPOINT  ["python", "my-flask-app.py"]