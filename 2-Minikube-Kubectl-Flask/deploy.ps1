# PowerShell deployment script for Exercise 2
Write-Host "=== Exercise 2: Deploying Python Flask App on Minikube ===" -ForegroundColor Cyan

docker build -t python-flask-app:latest .
minikube image load python-flask-app:latest

kubectl apply -f flask-deployment.yaml

Write-Host "Waiting for deployment rollout..." -ForegroundColor Yellow
kubectl rollout status deployment/python-flask-app --timeout=90s

Write-Host "=== Deployments ===" -ForegroundColor Green
kubectl get deployments -o wide

Write-Host "=== Pods ===" -ForegroundColor Green
kubectl get pods -l app=python-flask-app -o wide

Write-Host "=== Services ===" -ForegroundColor Green
kubectl get services -o wide

Write-Host "=== Exercise 2 Completed Successfully ===" -ForegroundColor Cyan
