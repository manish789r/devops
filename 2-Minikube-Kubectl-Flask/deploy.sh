#!/usr/bin/env bash
set -e

echo "=== Exercise 2: Deploying Flask App on Minikube ==="

# Build image and push into Minikube's Docker daemon
if command -v minikube &> /dev/null; then
  echo "Building image and loading into Minikube..."
  docker build -t python-flask-app:latest .
  minikube image load python-flask-app:latest
fi

# Apply Deployment and Service manifest
kubectl apply -f flask-deployment.yaml

# Wait for rollout to complete
kubectl rollout status deployment/python-flask-app --timeout=90s

echo "=== Deployments ==="
kubectl get deployments -o wide

echo "=== Pods ==="
kubectl get pods -l app=python-flask-app -o wide

echo "=== Services ==="
kubectl get services -o wide

echo "=== Exercise 2 Completed Successfully ==="
