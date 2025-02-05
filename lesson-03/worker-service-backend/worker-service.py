from flask import Flask, request, jsonify
import os

app = Flask(__name__)
'''
=== This is the BACKEND app ===
- The `worker-service` exposes an internal API endpoint (`/process`).
- It accepts text from `web-service` and applies two transformations:
  1. Word count - Counts the number of words in the text.
  2. Reverse text - Reverses the entire text.
- It returns the processed result to `web-service`.
'''

def get_env():
    WEB_SERVICE_NAME = os.getenv('WEB_SERVICE_NAME'),
    print(f"WEB_SERVICE_NAME = {WEB_SERVICE_NAME}")

def word_count(text):
    words = text.split()
    return len(words)

def reverse_text(text):
    reverse_text = text[::-1]
    return reverse_text

# this one actually belong to the frontend , but still is here ....
@app.route('/livetest')
def index():
    return "worker-service is alive !!! "

@app.route('/process', methods=['POST'])
def process():
    ## add try/catch
    data = request.json
    wc = word_count(data['text'])
    reverse = reverse_text(data['text'])
    print(f"Word count is: {wc}")
    print(f"Reverse text is:\n{reverse}")
    return jsonify({"Word count is:": wc}, {"Reverse text is" : "reverse"}), 201

def main():
    get_env()
    app.run(host='0.0.0.0', port=5002)

if __name__ == '__main__':
    main()