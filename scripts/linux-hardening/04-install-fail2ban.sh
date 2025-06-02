#!/bin/bash
# Install Fail2Ban

sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
