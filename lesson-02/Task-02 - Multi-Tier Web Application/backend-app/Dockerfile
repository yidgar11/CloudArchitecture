# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y curl  iputils-ping net-tools

# Copy the rest of the application code
COPY . .

# Expose port 8080 for Flask
EXPOSE 8080

# Command to run the application
CMD ["python", "redis-backend.py"]
