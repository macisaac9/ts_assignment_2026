#!/bin/bash

set -e # Exit on error

echo ">>> Configuring Kernel for Subnet Routing..."
# Persistent sysctl settings for Ubuntu 24.04
sudo tee /etc/sysctl.d/99-tailscale.conf <<EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

echo ">>> Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo ">>> Initializing Tailscale Node..."
# The --reset flag ensures a clean state if re-provisioned
sudo tailscale up \
  --authkey=tskey-auth-{unique_auth_key_string} \
  --advertise-routes=172.16.92.0/24 \
  --ssh \
  --hostname=tsubu22 \
  --accept-dns=true \
  --reset

# Allow michael to run tailscale commands without sudo
sudo tailscale set --operator=michael

echo ">>> Tailscale setup complete for tsubu22."