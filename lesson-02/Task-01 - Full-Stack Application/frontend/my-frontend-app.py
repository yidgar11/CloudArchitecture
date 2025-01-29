from flask import Flask, render_template, jsonify
import requests
import os

app = Flask(__name__)

# Get the backend URL from an environment variable
BACKEND_URL = os.getenv("BACKEND_URL", "http://default-backend-url/")  # set a default for check in logs for error
# shoulkd receive http://backend-service.fullstack-app.svc.cluster.local/

@app.route("/")
def index():
    try:
        # Fetch data from the backend server
        response = requests.get(BACKEND_URL)
        data = response.json()
        return render_template("index.html", message=data.get("message", "No message received"))
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
