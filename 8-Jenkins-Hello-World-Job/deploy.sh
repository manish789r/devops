#!/usr/bin/env bash
set -e

echo "=== Exercise 8: Jenkins Build Job — Local Execution Test ==="

# Step 1: Display the script contents
echo -e "\n[Step 1] Contents of hello-world.sh:"
cat hello-world.sh

# Step 2: Make executable and run it locally
echo -e "\n[Step 2] Running hello-world.sh locally..."
chmod +x hello-world.sh
./hello-world.sh

# Step 3: Simulate the expected Jenkins console output
echo -e "\n[Step 3] Expected Jenkins Console Output:"
echo "Started by user Admin"
echo "Building in workspace /var/jenkins_home/workspace/BuildTest"
echo "[BuildTest] $ /bin/sh -xe /tmp/jenkins_script.sh"
echo "+ echo 'Build triggered by Jenkins!'"
echo "Build triggered by Jenkins!"
echo "Finished: SUCCESS"

echo -e "\n=== Exercise 8 Completed Successfully ==="
