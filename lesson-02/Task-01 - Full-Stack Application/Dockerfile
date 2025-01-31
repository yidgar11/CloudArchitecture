FROM python:3.9-slim
LABEL authors="yidgar"

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt update &&  apt upgrade && apt install -y curl iputils-ping net-tools


# Copy application code
COPY app.py /app

# Expose the port Flask will run on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
