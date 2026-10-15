#!/usr/bin/env bash
set -e

echo "=== Exercise 10: Multi-Node Kubernetes Deployment with Pod Anti-Affinity ==="

# 1. Build Docker images locally
echo -e "\n[Step 1] Building container images for microservices..."
docker build -t product-catalog:latest -f Dockerfile.product .
docker build -t shopping-cart:latest -f Dockerfile.shopping .

# 2. Deploy Manifests to Kubernetes
echo -e "\n[Step 2] Applying Deployment manifests with PodAntiAffinity constraints..."
kubectl apply -f product_catalog_deployment.yaml
kubectl apply -f shopping_cart_deployment.yaml

echo -e "\n[Step 3] Exposing microservices via NodePort Services..."
kubectl apply -f product_catalog_service.yaml
kubectl apply -f shopping_cart_service.yaml

# 3. Verify Pod placement across cluster nodes
echo -e "\n[Step 4] Checking Pod distribution across worker nodes (-o wide)..."
kubectl get pods -o wide --show-labels

echo -e "\n[Step 5] Checking active services..."
kubectl get services -o wide

echo -e "\n=== Exercise 10 Multi-Node Deployment Successfully Orchestrated ==="
