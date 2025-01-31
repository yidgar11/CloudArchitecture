# Use Python base image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Copy application files
COPY . .

# Install dependencies
RUN pip install flask requests
RUN apt-get update &&  apt-get upgrade && apt-get install -y curl iputils-ping net-tools

# Expose port 5000 for Flask
EXPOSE 5000

# Run the Flask app
CMD ["python", "my-frontend-app.py"]
