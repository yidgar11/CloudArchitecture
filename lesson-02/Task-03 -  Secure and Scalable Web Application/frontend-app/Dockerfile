# Use Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy application code
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir flask requests
RUN apt-get update &&  apt-get upgrade && apt-get install -y curl iputils-ping net-tools

# Expose port 5000 for Flask app
EXPOSE 5000

# Run the application
CMD ["python", "frontend-app.py"]
