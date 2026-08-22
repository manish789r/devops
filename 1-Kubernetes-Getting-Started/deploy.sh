#!/usr/bin/env bash
set -e

echo "=== Exercise 1: Launching Nginx Pod and Exposing via Service ==="

# Apply the Pod manifest
kubectl apply -f pod.yaml

# Wait until the pod reaches Ready state
echo "Waiting for my-nginx-pod to become Ready..."
kubectl wait --for=condition=Ready pod/my-nginx-pod --timeout=60s

# Apply the Service manifest
kubectl apply -f service.yaml

# Show cluster state
echo "=== Pods ==="
kubectl get pods -o wide

echo "=== Services ==="
kubectl get services -o wide

echo "=== Exercise 1 Completed Successfully ==="
