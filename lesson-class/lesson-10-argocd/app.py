from flask import Flask

app = Flask(__name__)

## this is the decorator
@app.route("/")
def hello():
    return "Hello from Alex!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)