# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install pymongo flask
RUN apt-get update && apt-get install -y curl

# Expose port 5000 for the application
EXPOSE 5000

# Run the application
CMD ["python", "backend-app.py"]
