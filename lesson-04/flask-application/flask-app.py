from flask import Flask, request, jsonify
import psycopg2
import os
import logging

# Configure logging
base_dir=os.getenv('BASE_DIR')
log_file_path = f"{base_dir}/var/log/app.log"

# Ensure the log directory exists
log_dir = os.path.dirname(log_file_path)
os.makedirs(log_dir, exist_ok=True)

# Ensure the log file exists
if not os.path.exists(log_file_path):
    open(log_file_path, "a").close()  # Create an empty file

logging.basicConfig(filename=log_file_path, level=logging.INFO, format="%(asctime)s - %(message)s")


app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST'),
        database=os.getenv('DB_NAME'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD')
    )
    return conn

# this one actually belong to the frontend , but still is here ....
@app.route('/')
def index():
    logging.info("Flask app received a request on / ")
    return "Hello, World! \nflask-app is alive "

@app.route('/add', methods=['POST'])
def add_entry():
    logging.info("Flask app received a request on /add_entry ")
    data = request.json
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO entries (content) VALUES (%s)", (data['content'],))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"status": "success"}), 201

@app.route('/entries', methods=['GET'])
def get_entries():
    logging.info("Flask app received a request on /entries ")
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM entries")
    entries = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(entries)

def main():
    app.run(host='0.0.0.0', port=5000)

if __name__ == '__main__':
    main()