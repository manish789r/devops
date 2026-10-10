# PowerShell deployment script for Exercise 7: Jenkins CI Automation
Write-Host "=== Exercise 7: Jenkins CI Server Deployment & Initial Setup ===" -ForegroundColor Cyan

# Step 1: Launch the Jenkins container
Write-Host "`n[Step 1] Starting Jenkins LTS container on ports 8080 & 50000..." -ForegroundColor Yellow
docker run -d --name jenkins-server -p 8080:8080 -p 50000:50000 -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts

# Step 2: Confirm container is running
Write-Host "`n[Step 2] Checking container status..." -ForegroundColor Yellow
docker ps -f "name=jenkins-server"

# Step 3: Poll until the admin password is generated
Write-Host "`n[Step 3] Waiting for Jenkins to generate admin credentials..." -ForegroundColor Yellow
$maxRetries = 20
$retries = 0
$password = ""

while ($retries -lt $maxRetries) {
    Start-Sleep -Seconds 3
    $retries++
    $password = docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword 2>$null
    if ($password -and $password.Length -eq 32) {
        break
    }
    Write-Host "Still waiting... ($retries/$maxRetries)" -ForegroundColor DarkGray
}

Write-Host "`n=== Initial Admin Password ===" -ForegroundColor Green
Write-Host "$password" -ForegroundColor Cyan

# Step 4: Verify HTTP access
Write-Host "`n[Step 4] Verifying Jenkins UI at http://localhost:8080..." -ForegroundColor Yellow
$response = curl.exe -s -I http://localhost:8080/login
Write-Host "$response" -ForegroundColor Green

Write-Host "`n=== Exercise 7 Completed Successfully ===" -ForegroundColor Cyan
