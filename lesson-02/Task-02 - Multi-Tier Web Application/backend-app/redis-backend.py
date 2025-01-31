from flask import Flask, jsonify
import redis
import os

app = Flask(__name__)

# Retrieve host and port from environment variables
REDIS_HOST = os.getenv("REDIS_SERVICE_HOST", "localhost")
REDIS_PORT = os.getenv("REDIS_SERVICE_PORT", "6379")
REDIS_PASSWORD =  os.getenv("REDIS_PASSWORD", "mypass")

print(f"Connecting to Redis at {REDIS_HOST}:{REDIS_PORT}")

# Connect to Redis service using the service name as the host and service port (8080)
redis_client = redis.StrictRedis(host=REDIS_HOST,
                                 port=REDIS_PORT,
                                 password=REDIS_PASSWORD,
                                 decode_responses=True)

@app.route('/')
def index():
    try:
        # Set and get a key-value pair in Redis
        redis_client.set('key', 'Hello from Redis!')
        value = redis_client.get('key')
        return f"Key value is: {value}"
    except Exception as e:
        return f"Error connecting to Redis: {str(e)}"

@app.route('/test')
def get_all_keys():
    try:
        # Retrieve all keys in the Redis database
        keys = redis_client.keys('*')  # '*' matches all keys
        data = {key: redis_client.get(key) for key in keys}  # Get values for each key
        return jsonify(data)  # Return as JSON response
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
