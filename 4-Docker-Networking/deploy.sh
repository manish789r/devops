#!/usr/bin/env bash
set -e

echo "=== Exercise 4: Multi-Container Communication over a Docker Bridge Network ==="

# Step 1: Create the custom bridge network
echo -e "\n[Step 1] Creating bridge network 'app-bridge-net'..."
docker network create --driver bridge app-bridge-net

# Step 2: List all networks to confirm creation
echo -e "\n[Step 2] Listing all Docker networks..."
docker network ls

# Step 3: Inspect the new network
echo -e "\n[Step 3] Inspecting 'app-bridge-net'..."
docker network inspect app-bridge-net

# Step 4: Build the Flask REST API image
echo -e "\n[Step 4] Building Flask REST API image..."
docker build -t flask-rest-api .

# Step 5: Start all containers on the bridge network
echo -e "\n[Step 5] Starting containers on 'app-bridge-net'..."
docker run -d --name db-server --net=app-bridge-net -e MYSQL_ROOT_PASSWORD=secret mysql:latest
docker run -d --name cache-server --net=app-bridge-net redis:latest
docker run -d --name api-server --net=app-bridge-net -p 6001:6001 flask-rest-api

sleep 3

echo -e "\n=== Running Containers ==="
docker ps

# Step 6: Verify connectivity from api-server to db-server
echo -e "\n[Step 6] Pinging db-server from api-server..."
docker exec api-server ping -c 3 db-server

# Step 7: Verify connectivity from api-server to cache-server
echo -e "\n[Step 7] Pinging cache-server from api-server..."
docker exec api-server ping -c 3 cache-server

# Step 8: Hit the REST API endpoint
echo -e "\n[Step 8] Testing Flask REST API endpoint..."
curl -s http://localhost:6001/info

echo -e "\n\n=== Exercise 4 Completed Successfully ==="
