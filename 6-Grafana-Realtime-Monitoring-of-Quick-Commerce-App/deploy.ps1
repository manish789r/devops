# PowerShell deployment script for Exercise 6: Real-Time Operations Monitoring
Write-Host "=== Exercise 6: Real-Time Monitoring with Prometheus, Grafana & Python ===" -ForegroundColor Cyan

# 1. Build delivery_metrics image
Write-Host "`n[Step 1] Building Delivery Metrics simulator Docker image..." -ForegroundColor Yellow
docker build -t delivery_metrics .

# 2. Run delivery_metrics container
Write-Host "`n[Step 2] Running Delivery Metrics container on port 8000..." -ForegroundColor Yellow
docker run -d --name delivery_metrics -p 8000:8000 delivery_metrics

Start-Sleep -Seconds 3

# 3. Verify metrics endpoint
Write-Host "`n[Step 3] Querying Prometheus metrics from /metrics endpoint..." -ForegroundColor Yellow
curl.exe -s http://localhost:8000/metrics | Select-String -Pattern "total_deliveries|pending_deliveries|on_the_way_deliveries|average_delivery_time" -Context 0,1

Write-Host "`n=== Exercise 6 Deployment Completed Successfully ===" -ForegroundColor Cyan
