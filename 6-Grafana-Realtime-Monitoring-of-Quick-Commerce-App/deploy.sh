#!/usr/bin/env bash
set -e

echo "=== Exercise 6: Real-Time Monitoring with Prometheus, Grafana & Python ==="

# 1. Build delivery_metrics image
echo -e "\n[Step 1] Building Delivery Metrics simulator Docker image..."
docker build -t delivery_metrics .

# 2. Run delivery_metrics container
echo -e "\n[Step 2] Running Delivery Metrics container on port 8000..."
docker run -d --name delivery_metrics -p 8000:8000 delivery_metrics

sleep 3

# 3. Verify metrics endpoint
echo -e "\n[Step 3] Querying Prometheus metrics from /metrics endpoint..."
curl -s http://localhost:8000/metrics | grep -E "total_deliveries|pending_deliveries|on_the_way_deliveries|average_delivery_time"

echo -e "\n=== Exercise 6 Deployment Completed Successfully ==="
