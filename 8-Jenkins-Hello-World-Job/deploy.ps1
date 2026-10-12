# PowerShell execution script for Exercise 8: Jenkins Build Job
Write-Host "=== Exercise 8: Jenkins Build Job — Local Execution Test ===" -ForegroundColor Cyan

# Step 1: Display script contents
Write-Host "`n[Step 1] Contents of hello-world.sh:" -ForegroundColor Yellow
Get-Content hello-world.sh

# Step 2: Run locally via bash
Write-Host "`n[Step 2] Executing hello-world.sh directly..." -ForegroundColor Yellow
bash hello-world.sh

# Step 3: Simulate Jenkins Freestyle job console output
Write-Host "`n[Step 3] Expected Jenkins Console Output (BuildTest job):" -ForegroundColor Yellow
Write-Host "Started by user Admin" -ForegroundColor DarkGray
Write-Host "Building in workspace /var/jenkins_home/workspace/BuildTest" -ForegroundColor DarkGray
Write-Host "[BuildTest] `$ /bin/sh -xe /tmp/jenkins_script.sh" -ForegroundColor Cyan
Write-Host "+ echo 'Build triggered by Jenkins!'" -ForegroundColor Yellow
Write-Host "Build triggered by Jenkins!" -ForegroundColor Green
Write-Host "Finished: SUCCESS" -ForegroundColor Green

Write-Host "`n=== Exercise 8 Completed Successfully ===" -ForegroundColor Cyan
