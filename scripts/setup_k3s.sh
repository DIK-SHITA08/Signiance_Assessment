#!/bin/bash
set -e

echo "[+] Installing K3s..."
curl -sfL https://get.k3s.io | sh -

echo "[+] K3s installed. Checking status..."
sudo k3s kubectl get nodes

