from flask import Flask, jsonify
import os
import mysql.connector

app = Flask(__name__)

# Fetch MySQL connection details from environment variables
db_host = os.getenv("MYSQL_HOST", "localhost")
db_user = os.getenv("MYSQL_USER", "root")
db_password = os.getenv("MYSQL_PASSWORD", "")
db_name = os.getenv("MYSQL_DATABASE", "testdb")

@app.route("/")
def index():
    try:
        # Connect to MySQL
        conn = mysql.connector.connect(
            host=db_host,
            user=db_user,
            password=db_password,
            database=db_name
        )
        cursor = conn.cursor()
        cursor.execute("SELECT DATABASE();")
        db = cursor.fetchone()
        return jsonify({"message": f"Connected to database: {db[0]}"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
