from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/api/data', methods=['GET'])
def get_external_data():
    response = requests.get('https://jsonplaceholder.typicode.com/todos/1')
    if response.status_code == 200:
        data = response.json()
        return jsonify(data)
    else:
        return jsonify({'error': 'Failed to fetch data'}), response.status_code

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
