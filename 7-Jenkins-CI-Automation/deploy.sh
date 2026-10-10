#!/usr/bin/env bash
set -e

echo "=== Exercise 7: Jenkins CI Server Deployment & Initial Setup ==="

# Step 1: Launch the Jenkins container
echo -e "\n[Step 1] Starting Jenkins LTS container on ports 8080 & 50000..."
docker run -d --name jenkins-server -p 8080:8080 -p 50000:50000 -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts

# Step 2: Confirm container is running
echo -e "\n[Step 2] Checking container status..."
docker ps -f "name=jenkins-server"

# Step 3: Poll until Jenkins generates the initial admin password
echo -e "\n[Step 3] Waiting for Jenkins to initialise and generate admin credentials..."
max_retries=20
retries=0
password=""

while [ $retries -lt $max_retries ]; do
    sleep 3
    retries=$((retries + 1))
    password=$(docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null || true)
    if [ ${#password} -eq 32 ]; then
        break
    fi
    echo "Still waiting... ($retries/$max_retries)"
done

echo -e "\n=== Initial Admin Password ==="
echo "$password"

# Step 4: Verify HTTP access to Jenkins UI
echo -e "\n[Step 4] Verifying Jenkins web interface at http://localhost:8080..."
curl -s -I http://localhost:8080/login | head -n 5

echo -e "\n=== Exercise 7 Completed Successfully ==="
