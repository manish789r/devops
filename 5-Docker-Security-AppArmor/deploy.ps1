# PowerShell deployment script for Exercise 5: Docker Security with AppArmor
Write-Host "=== Exercise 5: Securing Docker Containers with AppArmor ===" -ForegroundColor Cyan

# Step 1: Build the Docker image
Write-Host "`n[Step 1] Building the secure Flask Docker image..." -ForegroundColor Yellow
docker build -t secure-flask .

# Step 2: Apply AppArmor profile using Python Docker SDK
Write-Host "`n[Step 2] Attaching AppArmor profile via Python Docker SDK..." -ForegroundColor Yellow
python apply_apparmor.py

# Step 3: Run restricted action verification tests
Write-Host "`n[Step 3] Running AppArmor restriction tests..." -ForegroundColor Yellow
python test_restricted_actions.py

Write-Host "`n=== Exercise 5 Completed Successfully ===" -ForegroundColor Cyan
