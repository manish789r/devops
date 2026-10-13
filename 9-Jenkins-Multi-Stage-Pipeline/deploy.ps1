# PowerShell execution script for Exercise 9: Jenkins Multi-Stage Pipeline
Write-Host "=== Exercise 9: Jenkins Multi-Stage Pipeline Simulation ===" -ForegroundColor Cyan

# 1. Run Unit Tests locally
Write-Host "`n[Step 1] Executing Automated Unit Tests (Test Stage)..." -ForegroundColor Yellow
python -m unittest test_app.py

# 2. Simulate Local Staging / Deployment
Write-Host "`n[Step 2] Staging Artifact to Deployment Target (Deploy Stage)..." -ForegroundColor Yellow
$deployDir = ".\flask-app-deploy"
New-Item -ItemType Directory -Force -Path $deployDir | Out-Null
Copy-Item app.py -Destination $deployDir
Write-Host "Application artifact app.py successfully staged at $deployDir" -ForegroundColor Green

# 3. Clean up staging directory
Remove-Item -Recurse -Force $deployDir

Write-Host "`n=== Exercise 9 Multi-Stage Pipeline Simulation Finished Successfully ===" -ForegroundColor Cyan
