# PowerShell deployment script for Exercise 4: Docker Networking
Write-Host "=== Exercise 4: Multi-Container Communication over a Docker Bridge Network ===" -ForegroundColor Cyan

# Step 1: Create the custom bridge network
Write-Host "`n[Step 1] Creating bridge network 'app-bridge-net'..." -ForegroundColor Yellow
docker network create --driver bridge app-bridge-net

# Step 2: List all networks
Write-Host "`n[Step 2] Listing all Docker networks..." -ForegroundColor Yellow
docker network ls

# Step 3: Inspect the network
Write-Host "`n[Step 3] Inspecting 'app-bridge-net'..." -ForegroundColor Yellow
docker network inspect app-bridge-net

# Step 4: Build the Flask REST API image
Write-Host "`n[Step 4] Building Flask REST API image..." -ForegroundColor Yellow
docker build -t flask-rest-api .

# Step 5: Start all containers
Write-Host "`n[Step 5] Starting containers on 'app-bridge-net'..." -ForegroundColor Yellow
docker run -d --name db-server --net=app-bridge-net -e MYSQL_ROOT_PASSWORD=secret mysql:latest
docker run -d --name cache-server --net=app-bridge-net redis:latest
docker run -d --name api-server --net=app-bridge-net -p 6001:6001 flask-rest-api

Start-Sleep -Seconds 3

Write-Host "`n=== Running Containers ===" -ForegroundColor Green
docker ps

# Step 6: Test connectivity
Write-Host "`n[Step 6] Pinging db-server from api-server..." -ForegroundColor Yellow
docker exec api-server ping -c 3 db-server

Write-Host "`n[Step 7] Pinging cache-server from api-server..." -ForegroundColor Yellow
docker exec api-server ping -c 3 cache-server

# Step 8: Hit the REST API
Write-Host "`n[Step 8] Testing Flask REST API endpoint..." -ForegroundColor Yellow
curl.exe http://localhost:6001/info

Write-Host "`n=== Exercise 4 Completed Successfully ===" -ForegroundColor Cyan
