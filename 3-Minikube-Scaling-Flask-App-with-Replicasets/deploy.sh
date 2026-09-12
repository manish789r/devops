#!/usr/bin/env bash
set -e

echo "=== Exercise 3: Scaling Flask App on Single Node using ReplicaSets ==="

# Build the Docker image
docker build -t saleapp:1.0 .

# Load it into Minikube
minikube image load saleapp:1.0

# Apply ReplicaSet and Service
kubectl apply -f sale-replicaset.yaml

# Wait for pods to be ready
echo "Waiting for pods to become Ready..."
kubectl wait --for=condition=Ready pods -l app=saleapp --timeout=90s

echo "=== Initial ReplicaSet & Pods (3 Replicas) ==="
kubectl get rs
kubectl get pods -l app=saleapp -o wide

# Scale up to 5 replicas
echo "=== Scaling ReplicaSet to 5 Replicas ==="
kubectl scale rs sale-rs --replicas=5
kubectl wait --for=condition=Ready pods -l app=saleapp --timeout=90s

echo "=== Scaled ReplicaSet & Pods (5 Replicas) ==="
kubectl get rs
kubectl get pods -l app=saleapp -o wide

# Test self-healing by removing one pod
FIRST_POD=$(kubectl get pods -l app=saleapp -o jsonpath="{.items[0].metadata.name}")
echo "=== Testing Self-Healing: Deleting pod $FIRST_POD ==="
kubectl delete pod $FIRST_POD

echo "=== Pods After Self-Healing ==="
kubectl get pods -l app=saleapp -o wide

echo "=== Exercise 3 Completed Successfully ==="
