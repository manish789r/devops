# Exercise 4: Multi-Container Communication over a Docker Bridge Network

## Objective
Learn Docker networking fundamentals by creating a custom bridge network and wiring multiple containers together so they can communicate using DNS-based service discovery.

## Scenario
Build and orchestrate a three-container web application:
- **Python Flask REST API** (Container 1 – `api-server`, exposed on port 6001)
- **MySQL Database** (Container 2 – `db-server`)
- **Redis Cache** (Container 3 – `cache-server`)

All three containers are connected through a user-defined bridge network (`app-bridge-net`) and resolve each other by container name via Docker's internal DNS.

## Key Concepts
- **User-Defined Bridge Network**: Unlike the default bridge, a custom bridge network provides automatic container-name DNS resolution, better isolation, and fine-grained control over which containers can communicate.
- **Port Mapping (`-p 6001:6001`)**: Exposes the Flask container's internal port to the host so HTTP requests can reach it from outside Docker.
- **Service Discovery**: Any container on the same custom network can reach another by simply using its container name (e.g., `ping db-server`, `ping cache-server`).

## Architecture & Components
- `app-bridge-net`: Custom bridge network with subnet `172.20.0.0/16`.
- `api-server`: Python 3.9 Flask REST API listening on port 6001 (`/info` endpoint).
- `db-server`: Official MySQL database container attached to `app-bridge-net`.
- `cache-server`: Official Redis cache container attached to `app-bridge-net`.

## Files in this Exercise
- `app.py`: Flask REST API serving the `/info` endpoint.
- `requirements.txt`: Python package requirements (`Flask==2.0.1`, `Werkzeug==2.2.2`).
- `Dockerfile`: Container image with network diagnostic tools (`iputils-ping`, `curl`).
- `deploy.ps1`: Automated PowerShell deployment and verification script.
- `deploy.sh`: Automated Bash deployment and verification script.
- `output.txt`: Raw terminal output captured during execution.

## Execution Steps

### 1. Create and Inspect the Bridge Network
```bash
docker network create --driver bridge app-bridge-net
docker network ls
docker network inspect app-bridge-net
```

### 2. Build the Flask Image
```bash
docker build -t flask-rest-api .
```

### 3. Start All Containers on the Bridge Network
```bash
docker run -d --name db-server --net=app-bridge-net -e MYSQL_ROOT_PASSWORD=secret mysql:latest
docker run -d --name cache-server --net=app-bridge-net redis:latest
docker run -d --name api-server --net=app-bridge-net -p 6001:6001 flask-rest-api
```

### 4. Test Container Connectivity
Exec into the Flask container and test DNS resolution / ICMP reachability:
```bash
docker exec api-server ping -c 3 db-server
docker exec api-server ping -c 3 cache-server
```

Access the Flask REST API from the host:
```bash
curl http://localhost:6001/info
```

### 5. Cleanup
```bash
docker stop db-server cache-server api-server && docker rm db-server cache-server api-server
docker network rm app-bridge-net
```

## Questions & Answers

**Q1: What does the `--net` flag do in `docker run`?**  
**A1:** The `--net` (or `--network`) flag attaches the container to a specific Docker network at startup, determining which other containers it can communicate with.

**Q2: How do containers on the same network discover each other?**  
**A2:** Docker provides a built-in DNS server for user-defined networks. Containers can reach each other using their container names as hostnames, which Docker resolves to their internal IP addresses automatically.

**Q3: What is the key difference between a bridge network and a host network?**  
**A3:**
- **Bridge Network**: Containers are placed in a private virtual network namespace, isolated from the host. Communication to the host or external networks happens through port mapping.
- **Host Network**: Removes isolation entirely — the container shares the host machine's network stack and IP address, with no port mapping needed.

**Q4: How do you expose a container port to the host machine?**  
**A4:** Use the `-p` or `--publish` flag (e.g., `-p 6001:6001`) which maps host port 6001 to container port 6001.

## Execution Proof & Screenshots

### 1. Bridge Network Creation, Inspection & Container Deployment
![Network Creation and Container Launch](screenshots/01_network_create_and_containers_launch.png)

### 2. Multi-Container Connectivity Verification & REST API Response
![Connectivity and API Verification](screenshots/02_test_connectivity_and_api.png)
