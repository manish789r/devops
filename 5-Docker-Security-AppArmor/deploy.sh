#!/usr/bin/env bash
set -e

echo "=== Exercise 5: Securing Docker Containers with AppArmor ==="

# Load the AppArmor profile into the Linux kernel if apparmor_parser is available
if command -v apparmor_parser &> /dev/null; then
    echo -e "\n[Step 0] Loading AppArmor profile into the kernel..."
    sudo cp my-apparmor-profile /etc/apparmor.d/my-apparmor-profile || true
    sudo apparmor_parser -r /etc/apparmor.d/my-apparmor-profile || true
fi

# Build the Docker image
echo -e "\n[Step 1] Building the secure Flask Docker image..."
docker build -t secure-flask .

# Apply AppArmor profile via the Python Docker SDK
echo -e "\n[Step 2] Attaching AppArmor profile using Python Docker SDK..."
python3 apply_apparmor.py

# Run restricted action tests
echo -e "\n[Step 3] Verifying AppArmor confinement with restricted action tests..."
python3 test_restricted_actions.py

echo -e "\n=== Exercise 5 Completed Successfully ==="
