# Signiance Assessment - DevOps Implementation

This repository demonstrates an end-to-end DevOps workflow including infrastructure provisioning, application deployment, automation, observability, and security best practices.

---

## 📁 Repository Structure

Signiance_Assessment/
├── app/ # Node.js application (Dockerized)
├── k8s/ # Kubernetes manifests and Helm chart
├── scripts/ # Shell and Ansible setup scripts
├── terraform/ # Infrastructure provisioning
├── .github/workflows/ # GitHub Actions CI/CD pipeline


---

## 🚀 Features Implemented

### 1. Infrastructure Provisioning (Terraform)
- EC2 instance (Ubuntu)
- Security groups, SSH access
- Outputs public IP for provisioning

### 2. Linux Hardening
- Disabled root SSH login
- Added sudo-enabled user with SSH key
- Firewall via UFW
- Fail2ban for intrusion prevention

### 3. App Deployment
- Node.js app with `/metrics` endpoint
- Dockerized and pushed to Docker Hub

### 4. Kubernetes + Helm
- Helm chart to deploy app
- Configurable via `values.yaml`
- Pod annotations for Prometheus
- Probes, resource limits, ConfigMaps, Secrets

### 5. CI/CD Pipeline
- GitHub Actions workflow:
  - Build & push Docker image
  - Deploy using Helm
  - Secure via GitHub Secrets (`KUBECONFIG`, `DOCKER_USERNAME`, `DOCKER_PASSWORD`)

### 6. Monitoring & Alerting
- Prometheus & Grafana via Helm
- Scraping app metrics
- Dashboards for CPU, memory, event loop, heap
- Alerts:
  - CPU > 70%
  - Pod crash/restart

### 7. Ansible Automation
- Docker, k3s, Helm installation
- Hardening steps automated

---

## ⚙️ Prerequisites

Ensure the following tools are installed on your local machine or provisioned VM:

- **Terraform** >= v1.0.0
- **Docker** >= v20
- **Helm** >= v3
- **kubectl**
- **k3s** (or compatible Kubernetes distribution)
- **Ansible** (for optional automation)

---

## 🔧 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/DIK-SHITA08/Signiance_Assessment.git
cd Signiance_Assessment

2. Provision Infrastructure with Terraform

cd terraform
terraform init
terraform apply -auto-approve

3. SSH into the EC2 Instance
ssh -i <key.pem> ubuntu@<ec2-public-ip>

4. Install K3s and Helm
bash
Copy
Edit
sudo bash scripts/setup_k3s.sh

🐳 Docker Image
Build & Push
bash
Copy
Edit
docker build -t yourdockerhub/signiance-node-app:latest ./app
docker push yourdockerhub/signiance-node-app:latest
📦 Deploy with Helm
bash
Copy
Edit
helm upgrade --install nodejs-app ./k8s/helm/node-app --namespace default
🤖 GitHub Actions CI/CD
Trigger
On push to main, the workflow will:

Build Docker image

Push to Docker Hub

Deploy to cluster using Helm

GitHub Secrets Required
DOCKER_USERNAME

DOCKER_PASSWORD

KUBECONFIG (base64 encoded content of ~/.kube/config)

📊 Observability
Prometheus
URL: http://<ec2-ip>:<prometheus-nodeport>/targets

Grafana
URL: http://<ec2-ip>:<grafana-nodeport>

Import Dashboard ID: 13433

Sample Metrics: process_cpu_seconds_total, nodejs_eventloop_lag_seconds

🔁 Reproducing on a Fresh VM
Clone repo and run Terraform

SSH into instance and run the setup script

Push app changes to trigger CI/CD

