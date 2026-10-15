from flask import Flask, jsonify, request

app = Flask(__name__)

# In-memory storage for active cart items
cart_items = []

@app.route("/", methods=["GET"])
def health():
    return jsonify({
        "service": "Shopping Cart Microservice",
        "status": "healthy",
        "total_cart_items": len(cart_items)
    })

@app.route("/cart", methods=["GET"])
def retrieve_cart():
    total_value = sum(item.get("price", 0) * item.get("quantity", 1) for item in cart_items)
    return jsonify({
        "items": cart_items,
        "item_count": len(cart_items),
        "total_value": round(total_value, 2)
    })

@app.route("/cart", methods=["POST"])
def add_item_to_cart():
    payload = request.get_json(silent=True) or {}
    if not payload:
        return jsonify({"error": "Invalid JSON body provided"}), 400

    required_keys = ["id", "name"]
    for key in required_keys:
        if key not in payload:
            return jsonify({"error": f"Missing required attribute: {key}"}), 400

    payload.setdefault("quantity", 1)
    payload.setdefault("price", 0.0)
    cart_items.append(payload)

    return jsonify({
        "message": f"Successfully added '{payload['name']}' to cart.",
        "cart": cart_items
    }), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
