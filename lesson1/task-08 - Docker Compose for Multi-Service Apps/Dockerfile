FROM python:3.9-slim
LABEL authors="yidgar"
WORKDIR /app
COPY ./app /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000

# Command to run the application
CMD ["python", "my-flask-app.py"]
