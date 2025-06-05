# 🚀 DevOps Project: Infra, Deployment & Monitoring

This repo shows how to set up infrastructure, secure your server, deploy a Node.js app using Docker, automate with GitHub Actions, and run it on Kubernetes with monitoring.

---

# Architecture diagram
![image](https://github.com/user-attachments/assets/3a73ede3-71ce-4ebe-81e5-b72c43c0fe91)

## 🔧 Step 1: Set Up Infrastructure (Terraform)

1. Install Terraform and AWS CLI.
2. Configure AWS CLI:
   ```bash
   aws configure
   ```
3. Generate SSH key:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/k3s_key
   ```
4. Go to `terraform/` folder and run:
   ```bash
   terraform init
   terraform apply
   ```

This will create an EC2 instance and security groups.

---

## 🔒 Step 2: Secure the EC2 (Linux Hardening)

1. SSH into your EC2:
   ```bash
   ssh -i "./.ssh/k3s_key" ubuntu@<EC2-PUBLIC-IP>
   ```
2. Clone this repo inside EC2 or copy scripts from `linux_hardening/`.
3. Run the scripts to:
   - Disable root SSH
   - Add a non-root user
   - Enable firewall (UFW)
   - Setup fail2ban and logrotate

---

## 📦 Step 3: Deploy the App (Docker)

1. Go to the `app/` folder:
   ```bash
   cd app
   docker build -t signiance-node-app .
   docker run -p 3000:3000 signiance-node-app
   ```
2. Or push the image to Docker Hub.

---

## 🔁 Step 4: CI/CD (GitHub Actions)

1. Update `.github/workflows/ci-cd.yaml`:
   - Add your Docker image name
   - Set GitHub secrets: `DOCKER_USERNAME` and `DOCKER_PASSWORD`
2. Push changes to GitHub.
3. GitHub Actions will build and push your Docker image.

---

## ☸️ Step 5: Run on Kubernetes (K3s + Helm)

1. SSH into EC2 and run:
   ```bash
   chmod +x scripts/setup_k3s.sh
   ./scripts/setup_k3s.sh
   ```
2. Copy your kube config and add it as a GitHub secret:
   ```bash
   cat ~/.kube/config | base64 -w 0
   ```
3. Uncomment the Helm section in the GitHub workflow and push to GitHub.



# 🔧 Step 6: Ansible Automation

---

## ✅ Prerequisites

- Windows 10/11 system with administrator access or linux machine 
- Internet connection
- EC2 private key file (e.g., `my-key.pem`)
- Git installed (optional but recommended)

---

##  Install WSL

Open **PowerShell as Administrator** and run the following command:

```powershell
wsl --install
````

> 📌 **Note:** if you have linux than you can directly copy playbooks and run it.

Reboot your computer when prompted. After reboot, WSL will install Ubuntu or prompt you to choose a Linux distribution.

---


##  Install Ansible

In the Ubuntu terminal, execute the following commands:

```bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
```
---

## Running Ansible Playbooks

1. Ensure your EC2 private key is saved under:

```bash
/home/<your-username>/.ssh/my-key.pem
```
 
 you can copy from you local system 
 ```bash
 ssh -i ~/.ssh/k3s-key ubuntu@54.92.134.209
```

2. Change file permission (if needed):

```bash
chmod 600 ~/.ssh/my-key.pem
```

3. Run your Ansible playbook using:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

Replace `inventory.ini` and `playbook.yml` 

---


## 📊 Step 7: Monitoring (Prometheus + Grafana)

1. Add Helm repos and install monitoring tools:
   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo add grafana https://grafana.github.io/helm-charts
   kubectl create namespace monitoring

   helm install prometheus prometheus-community/prometheus --namespace monitoring
   helm install grafana grafana/grafana --namespace monitoring --set adminPassword='admin' --set service.type=NodePort
   ```
2. Access Grafana and Prometheus in browser:
   - Grafana: `http://<EC2-IP>:32000`
   - Prometheus: `http://<EC2-IP>:32001`

---

## ✅ Done!

You now have a complete pipeline: Infra → Secure Server → Docker App → CI/CD → Kubernetes → Monitoring.

---

**Note:** Use `t3.large` or better instance if you face memory issues.
