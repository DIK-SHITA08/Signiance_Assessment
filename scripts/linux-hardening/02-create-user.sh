#!/bin/bash
# Create user `signiance` with sudo privileges

USERNAME="signiance"

sudo adduser $USERNAME
sudo usermod -aG sudo $USERNAME

# Add public SSH key to user's authorized_keys
sudo mkdir -p /home/$USERNAME/.ssh
sudo cp ~/.ssh/authorized_keys /home/$USERNAME/.ssh/
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
