#!/usr/bin/env bash
set -e

echo "=== Exercise 9: Jenkins Multi-Stage Pipeline Execution ==="

# 1. Run Unit Tests
echo -e "\n[Step 1] Running Automated Unit Tests (Test Stage)..."
python3 -m unittest test_app.py

# 2. Deploy Stage
echo -e "\n[Step 2] Staging Application Artifact (Deploy Stage)..."
mkdir -p ./flask-app-deploy
cp app.py ./flask-app-deploy/
echo "Artifact app.py successfully staged to ./flask-app-deploy"

# 3. Clean up
rm -rf ./flask-app-deploy

echo -e "\n=== Exercise 9 Multi-Stage Pipeline Simulation Finished Successfully ==="
