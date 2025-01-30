from flask import Flask, jsonify, render_template
import requests

app = Flask(__name__)

# Backend service URL (ClusterIP service name in Kubernetes)
BACKEND_URL = "http://python-backend-service.secure-app.svc.cluster.local/test"

@app.route('/')
def home():
    try:
        # Call the backend /test API
        response = requests.get(BACKEND_URL)
        response.raise_for_status()  # Raise an error if the request fails
        data = response.json()  # Assuming the backend returns JSON data
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500

    return render_template("index.html", data=data)  # Pass data to the frontend template


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
