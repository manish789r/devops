from prometheus_client import start_http_server, Summary, Gauge
import random
import time

# Define Prometheus metrics for ZAPPTTO delivery operations
total_orders = Gauge("total_orders", "Total number of orders processed")
pending_orders = Gauge("pending_orders", "Number of orders awaiting dispatch")
dispatched_orders = Gauge("dispatched_orders", "Number of orders currently out for delivery")
avg_dispatch_time = Summary("avg_dispatch_time", "Average time to dispatch an order in seconds")

# Simulate real-time order status data
def simulate_orders():
    pending = random.randint(10, 20)    # Kept above alert threshold to trigger alerts
    dispatched = random.randint(5, 20)
    completed = random.randint(30, 70)
    dispatch_time = random.uniform(15, 45)

    total = pending + dispatched + completed

    print(f"[DEBUG] Total orders:      {total}")
    print(f"[DEBUG] Pending orders:    {pending}")
    print(f"[DEBUG] Dispatched orders: {dispatched}")
    print(f"[DEBUG] Avg dispatch time: {dispatch_time:.2f}s")

    total_orders.set(total)
    pending_orders.set(pending)
    dispatched_orders.set(dispatched)
    avg_dispatch_time.observe(dispatch_time)

if __name__ == "__main__":
    print("[INFO] Starting metrics HTTP server on port 8000...")
    start_http_server(8000, addr="0.0.0.0")
    print("[INFO] Server running. Simulating ZAPPTTO order metrics...")
    try:
        while True:
            simulate_orders()
            print("[INFO] Refreshing in 1 second...")
            time.sleep(1)
    except KeyboardInterrupt:
        print("[INFO] Simulation stopped by user.")
