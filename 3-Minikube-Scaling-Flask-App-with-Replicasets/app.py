# app.py
from flask import Flask, request
import socket, time, random

app = Flask(__name__)

@app.get("/")
def homepage():
    return {
        "message": "Welcome to the Online Sale!",
        "pod": socket.gethostname(),
        "ts": time.time()
    }

@app.get("/order")
def order():
    # Simulate an item order during a sale event
    item = random.choice(["Tablet", "Watch", "Keyboard", "Monitor"])
    user = request.args.get("user", f"user{random.randint(1,1000)}")
    return {
        "status": "order_placed",
        "item": item,
        "user": user,
        "handled_by": socket.gethostname(),
        "time": time.strftime("%H:%M:%S")
    }

@app.get("/health")
def health():
    return {"status": "ok", "pod": socket.gethostname()}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
