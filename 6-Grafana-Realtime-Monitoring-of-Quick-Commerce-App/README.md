# Exercise 6: Real-Time Operations Monitoring and Alerting

## Objective
Build and deploy a complete real-time monitoring, visualisation, and alerting stack for a quick-commerce delivery service (ZAPPTTO) using Python, Prometheus, Grafana, and Jenkins CI/CD automation.

## Business Context & Scenario
ZAPPTTO operates a 10-minute grocery delivery model where operational delays translate directly into SLA violations and customer dissatisfaction:
- Sudden spikes in pending orders or driver dispatch delays must be caught immediately.
- DevOps engineers monitor four key metrics in real time: `total_orders`, `pending_orders`, `dispatched_orders`, and `avg_dispatch_time`.
- Automated alerts fire when pending orders exceed safe thresholds or when average dispatch time surpasses 30 seconds.

## Architecture & Monitoring Stack
- **Python Metrics Generator (`delivery_metrics.py`)**: Exposes simulated operational metrics via HTTP on port 8000 (`/metrics`) using `prometheus_client`.
- **Prometheus (`prometheus.yml`, `alert_rules.yml`)**: Scrapes the `/metrics` endpoint every 15 seconds and evaluates alert rules (`HighPendingOrders`, `HighDispatchTime`).
- **Grafana**: Displays four real-time dashboard panels:
  - Panel 1: Total Orders (`total_orders`)
  - Panel 2: Pending Orders (`pending_orders`)
  - Panel 3: Dispatched Orders (`dispatched_orders`)
  - Panel 4: Average Dispatch Time (`avg_dispatch_time_sum / avg_dispatch_time_count`)
- **Jenkins (`Jenkinsfile`)**: Automates pre-flight checks, workspace setup, image build, and full stack deployment.

## Files in this Exercise
- `delivery_metrics.py`: Metrics simulation script using Gauges and Summaries.
- `prometheus.yml`: Prometheus scrape configuration.
- `alert_rules.yml`: Alerting threshold rule definitions.
- `Jenkinsfile`: Declarative CI/CD pipeline for automated stack deployment.
- `Dockerfile`: Container image definition for the metrics service.
- `requirements.txt`: Python library dependencies (`prometheus-client`).
- `deploy.ps1`: Automated deployment script for PowerShell.
- `deploy.sh`: Automated deployment script for Linux/WSL.
- `output.txt`: Captured console execution output.

## How to Run

### 1. Build and Start the Metrics Simulator
```bash
docker build -t zapptto_metrics .
docker run -d --name zapptto_metrics -p 8000:8000 zapptto_metrics
```

### 2. Verify the Scrape Endpoint
```bash
curl http://localhost:8000/metrics
```

### 3. Start Prometheus with Alert Rules Mounted
```bash
docker run -d --name prometheus -p 9090:9090 \
  -v ${PWD}/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v ${PWD}/alert_rules.yml:/etc/prometheus/alert_rules.yml \
  prom/prometheus
```

### 4. Start the Grafana Dashboard
```bash
docker run -d --name grafana -p 3000:3000 grafana/grafana
```
- Access Grafana at `http://localhost:3000` (default login: `admin` / `admin`).
- Add Prometheus as a Data Source at `http://localhost:9090` (or `http://host.docker.internal:9090`).
- Build 4 panels for the ZAPPTTO delivery metrics.

### 5. Teardown
```bash
docker stop zapptto_metrics prometheus grafana
docker rm zapptto_metrics prometheus grafana
```

## Execution Proof & Screenshots

### 1. Delivery Metrics Simulation & Prometheus Endpoint Verification
![Metrics Simulation and Scrape Endpoint](screenshots/01_metrics_simulation_and_endpoint.png)

### 2. Alert Rules Configuration & Containerised Stack Execution
![Alert Rules and Monitoring Stack](screenshots/02_alert_rules_and_monitoring_stack.png)
