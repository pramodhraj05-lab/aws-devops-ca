# Automated Cloud Deployment Project

## Overview

This project demonstrates an end-to-end automated deployment of a containerised web application on AWS. The solution integrates Infrastructure as Code, configuration management, containerisation, and CI/CD automation.

The system provisions cloud infrastructure, configures the server environment, deploys a Docker container, and makes the application accessible through a static public IP address.

## Deployment Flow

Code Push → GitHub Actions → Terraform → AWS EC2 → Ansible → Docker → Web Browser

- Code is pushed to GitHub.
- GitHub Actions triggers the deployment pipeline.
- Terraform provisions the EC2 instance, security group, and Elastic IP.
- Ansible installs and configures Docker on the server.
- The Docker container runs the web application on port 80.
- The application is accessed via the Elastic IP.

## Tools Used

- Terraform – Infrastructure provisioning  
- Ansible – Server configuration  
- Docker – Application containerisation  
- GitHub Actions – CI/CD automation  
- AWS EC2 – Cloud hosting  

## Key Design Decision

An Elastic IP was used instead of a dynamic public IP to ensure stable connectivity for SSH access, Ansible configuration, and CI/CD deployments.
