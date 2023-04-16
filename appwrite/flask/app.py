from flask import Flask, jsonify
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)


@app.route('/.well-known/assetlinks.json', methods=['GET'])
def assetlinks_json():
    json_data = json.load(open('assetlinks.json'))
    return jsonify(json_data)


if __name__ == '__main__':
    app.run( host="0.0.0.0", port=3000)
