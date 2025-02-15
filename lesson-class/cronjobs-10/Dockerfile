# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create a directory for logs
RUN mkdir -p /app/logs

# Run the Python script when the container launches
CMD ["python", "script.py"]