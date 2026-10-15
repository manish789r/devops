# PowerShell deployment script for Exercise 10: Multi-Node Multi-App Minikube Deployment
Write-Host "=== Exercise 10: Multi-Node Kubernetes Deployment with Pod Anti-Affinity ===" -ForegroundColor Cyan

# 1. Build Docker images locally
Write-Host "`n[Step 1] Building container images for microservices..." -ForegroundColor Yellow
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .

# 2. Deploy Manifests to Kubernetes
Write-Host "`n[Step 2] Applying Deployment manifests with PodAntiAffinity constraints..." -ForegroundColor Yellow
kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f shopping_cart_deployment.yaml

Write-Host "`n[Step 3] Exposing microservices via NodePort Services..." -ForegroundColor Yellow
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_service.yaml

# 3. Verify Pod placement across cluster nodes
Write-Host "`n[Step 4] Checking Pod distribution across worker nodes (-o wide)..." -ForegroundColor Yellow
kubectl get pods -o wide --show-labels

Write-Host "`n=== Active Kubernetes Services ===" -ForegroundColor Green
kubectl get services -o wide

Write-Host "`n=== Exercise 10 Multi-Node Deployment Successfully Orchestrated ===" -ForegroundColor Cyan
