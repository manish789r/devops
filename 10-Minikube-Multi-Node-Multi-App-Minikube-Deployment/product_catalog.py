from flask import Flask, jsonify

app = Flask(__name__)

# Predefined inventory of electronic equipment and developer accessories
CATALOG = [
    {"id": 101, "name": "Mechanical Keyboard", "category": "Hardware", "price": 110.00, "in_stock": True},
    {"id": 102, "name": "UltraWide 4K Monitor", "category": "Displays", "price": 420.00, "in_stock": True},
    {"id": 103, "name": "Noise-Cancelling Headphones", "category": "Audio", "price": 180.00, "in_stock": True},
    {"id": 104, "name": "USB-C Multi-Port Hub", "category": "Accessories", "price": 55.00, "in_stock": False},
]

@app.route("/", methods=["GET"])
def index():
    return jsonify({
        "service": "Product Catalog Service",
        "status": "healthy",
        "endpoints": ["/products"]
    })

@app.route("/products", methods=["GET"])
def get_products():
    return jsonify({
        "count": len(CATALOG),
        "items": CATALOG
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
