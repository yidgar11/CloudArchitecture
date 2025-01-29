from flask import Flask, jsonify, request
from pymongo import MongoClient
import os

app = Flask(__name__)

# MongoDB Configuration
MONGO_USER = os.getenv("MONGO_USER", "adminuser")  # Default to "adminuser" if not set
MONGO_PASSWORD = os.getenv("MONGO_PASSWORD", "password")  # Default to "password" if not set
MONGO_HOST = os.getenv("MONGO_HOST", "localhost")  # Default to "localhost" if not set
MONGO_PORT = os.getenv("MONGO_PORT", "27017")  # Default to "27017" if not set
MONGO_AUTH_DB = os.getenv("MONGO_AUTH_DB", "admin")  # Default to "admin" auth database

# Build the MongoDB URI dynamically from environment variables
MONGO_URI = f"mongodb://{MONGO_USER}:{MONGO_PASSWORD}@{MONGO_HOST}:{MONGO_PORT}/{MONGO_AUTH_DB}"
client = MongoClient(MONGO_URI)

# Access a specific database and collection
db = client.mydatabase
collection = db.mycollection

@app.route('/')
def home():
    return jsonify({"message": "Hello, this is your Python backend running!"})

@app.route('/api/data', methods=['GET'])
def get_data():
    data = list(collection.find({}, {"_id": 0}))  # Exclude MongoDB's _id field
    return jsonify({"data": data})

@app.route('/api/data', methods=['POST'])
def insert_data():
    new_data = request.json  # Get JSON payload from request
    if not new_data:
        return jsonify({"error": "No data provided"}), 400

    collection.insert_one(new_data)  # Insert data into MongoDB
    return jsonify({"message": "Data inserted successfully!"}), 201

# New endpoint: List all databases
@app.route('/test', methods=['GET'])
def list_databases():
    try:
        databases = client.list_database_names()  # Get a list of all database names
        return jsonify({"databases": databases})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
