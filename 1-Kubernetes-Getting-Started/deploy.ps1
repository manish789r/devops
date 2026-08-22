# Exercise 1: Launch Nginx Pod on Kubernetes (PowerShell)
Write-Host "=== Exercise 1: Launching Nginx Pod and Exposing via Service ===" -ForegroundColor Cyan

kubectl apply -f pod.yaml
Write-Host "Waiting for my-nginx-pod to reach Ready state..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready pod/my-nginx-pod --timeout=60s

kubectl apply -f service.yaml

Write-Host "=== Pods ===" -ForegroundColor Green
kubectl get pods -o wide

Write-Host "=== Services ===" -ForegroundColor Green
kubectl get services -o wide

Write-Host "=== Exercise 1 Completed ===" -ForegroundColor Cyan
