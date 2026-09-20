from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/info', methods=['GET'])
def info():
    return jsonify({
        "service": "Flask REST API",
        "version": "2.0",
        "description": "Multi-container REST API connected via Docker bridge network."
    })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=6001)
