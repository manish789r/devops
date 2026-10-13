# Exercise 9: Jenkins Multi-Stage CI/CD Pipeline for a Python Flask Application

## Objective
Design, implement, and execute a multi-stage Jenkins declarative pipeline that automates the full **Build → Test → Deploy → Run → Verify** lifecycle for a containerised Python Flask application.

## Pipeline Architecture & Stages
1. **Build Stage**: Installs all Python dependencies listed in `requirements.txt` into the runtime environment.
2. **Test Stage**: Discovers and executes automated unit tests (`unittest discover -s .`) against the Flask test client.
3. **Deploy Stage**: Copies the application artifact into a staging directory (`${WORKSPACE}/flask-app-deploy`).
4. **Run Application**: Launches the Flask application as a background process using `nohup`.
5. **Test Application (Integration)**: Sends a live HTTP request to verify the deployed service responds correctly.
6. **Post Actions**: Reports overall pipeline outcome (`success` / `failure` blocks).

## Files in this Exercise
- `app.py`: Flask application exposing a `"/"` endpoint.
- `requirements.txt`: Python dependencies (`flask==2.1.2`, `Werkzeug==2.2.2`).
- `test_app.py`: Unit test suite verifying HTTP 200 response and response body.
- `Jenkinsfile`: Multi-stage declarative Jenkins pipeline definition.
- `deploy.ps1`: Automated PowerShell local test script.
- `deploy.sh`: Automated Bash execution script.
- `output.txt`: Captured pipeline stage logs and test results.

## How to Run

### 1. Run Unit Tests Locally
```bash
python -m unittest test_app.py
```

### 2. Configure the Jenkins Pipeline
1. In the Jenkins dashboard, click **New Item** → Name: `Flask-CI-Pipeline` → Select **Pipeline**.
2. Under **Pipeline Definition**, select **Pipeline script from SCM**.
3. Set SCM to **Git**, provide your repository URL, and set the script path to `Jenkinsfile`.
4. Click **Save** and trigger **Build Now**.

### 3. Install Python in the Jenkins Container (if missing)
```bash
docker exec -it -u root jenkins-server bash
apt-get update && apt-get install -y python3 python3-pip python3-flask
```

## Execution Proof & Screenshots

### 1. Flask Application Structure & Local Unit Test Verification
![Unit Test Verification](screenshots/01_flask_app_and_unit_tests.png)

### 2. Multi-Stage Jenkins Pipeline Stage Execution
![Pipeline Stage Execution](screenshots/02_jenkins_multistage_pipeline_execution.png)
