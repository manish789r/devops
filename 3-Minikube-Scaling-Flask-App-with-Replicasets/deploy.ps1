# PowerShell deployment script for Exercise 3
Write-Host "=== Exercise 3: Scaling Flask App with ReplicaSets ===" -ForegroundColor Cyan

docker build -t saleapp:1.0 .
minikube image load saleapp:1.0

kubectl apply -f sale-replicaset.yaml

Write-Host "Waiting for pods to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready pods -l app=saleapp --timeout=90s

Write-Host "=== Initial ReplicaSet & Pods (3 Replicas) ===" -ForegroundColor Green
kubectl get rs
kubectl get pods -l app=saleapp -o wide

Write-Host "=== Scaling ReplicaSet to 5 Replicas ===" -ForegroundColor Yellow
kubectl scale rs sale-rs --replicas=5
kubectl wait --for=condition=Ready pods -l app=saleapp --timeout=90s

Write-Host "=== Scaled ReplicaSet & Pods (5 Replicas) ===" -ForegroundColor Green
kubectl get rs
kubectl get pods -l app=saleapp -o wide

Write-Host "=== Exercise 3 Completed Successfully ===" -ForegroundColor Cyan
