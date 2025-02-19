#!/bin/bash
set -e  # Stop execution on error

echo "Stopping and disabling services..."
sudo systemctl stop jenkins || true
sudo systemctl disable jenkins || true
sudo systemctl stop docker || true
sudo systemctl disable docker || true

echo "Removing Jenkins and its dependencies..."
sudo apt-get remove --purge -y jenkins openjdk-17-jdk
sudo rm -rf /var/lib/jenkins /etc/default/jenkins /var/log/jenkins /usr/share/keyrings/jenkins-keyring.asc /etc/apt/sources.list.d/jenkins.list

echo "Removing Docker and its dependencies..."
sudo apt-get remove --purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo rm -rf /var/lib/docker /etc/docker /var/run/docker.sock /usr/share/keyrings/docker.asc /etc/apt/sources.list.d/docker.list

echo "Removing Trivy and its dependencies..."
sudo apt-get remove --purge -y trivy
sudo rm -rf /usr/share/keyrings/trivy.gpg /etc/apt/sources.list.d/trivy.list

echo "Cleaning up unnecessary packages and dependencies..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "All installations removed successfully!"
