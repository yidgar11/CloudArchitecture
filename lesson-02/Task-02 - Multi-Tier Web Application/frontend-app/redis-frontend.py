from flask import Flask, render_template
import requests
import os

app = Flask(__name__)

BACKEND_HOST = os.getenv("BACKEND_HOST", "backend-service")
BACKEND_PORT = os.getenv("BACKEND_PORT", "8080")
REDIS_PASSWORD = os.getenv("REDIS_PASSWORD", "mypass")

# Backend API URL (update this with the correct backend service URL)
BACKEND_API_URL = f"http://{BACKEND_HOST}:{BACKEND_PORT}/test"


@app.route('/')
def index():
    try:
        # Fetch data from the backend API
        response = requests.get(BACKEND_API_URL)
        response.raise_for_status()  # Raise an error for bad HTTP responses
        data = response.json()  # Parse JSON response
    except Exception as e:
        data = {"error": f"Failed to fetch data: {str(e)}"}

    # Render the HTML template and pass the data to it
    return render_template('index.html', data=data)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
