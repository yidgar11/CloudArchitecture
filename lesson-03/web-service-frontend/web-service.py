from flask import Flask, request, jsonify
import os
import requests

app = Flask(__name__)
'''
=== This is the BACKEND app ===
- The `web-service` exposes an HTTP endpoint (`/analyze`).
- It accepts a JSON payload containing a text string.
- It forwards the text to `worker-service` for processing.
- It waits for a response and returns the processed text to the user.
'''

WORKER_SERVICE_NAME = os.getenv('WORKER_SERVICE_NAME')
print(f"WORKER_SERVICE_NAME = {WORKER_SERVICE_NAME}")


def forward_request_to_worker(data):
    try:
        # Define the URL of the worker Flask app
        worker_url = f"http://{WORKER_SERVICE_NAME}:5002/process"

        # Send a POST request to the worker app with JSON data
        response = requests.post(worker_url, json=data)

        # Return the response received from the worker app
        return response.json()
    except Exception as e:
        # Handle any exceptions during the HTTP request
        return {"error": str(e)}

# this one actually belong to the frontend , but still is here ....
@app.route('/livetest')
def index():
    return "web-service is alive !!! "

@app.route('/analyze', methods=['POST'])
def analyze_text():
    try:
        data = request.json

        # Forward the request to the worker Flask app
        response = forward_request_to_worker(data)
        print(f"response is {response}")

        return response
        #return jsonify({"status": "success"}), 201
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

def main():
    app.run(host='0.0.0.0', port=5001)

if __name__ == '__main__':
    main()
