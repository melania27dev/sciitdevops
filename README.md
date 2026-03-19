### This project demonstrates an end-to-end DevOps workflow using:
- Terraform for infrastructure provisioning
- GitHub Actions for CI/CD
- AWS & Azure for cloud infrastructure
- Ansible for configuration management
- K3s (Lightweight Kubernetes)
- ArgoCD for GitOps
- Jenkins (deployed via ArgoCD)
- Prometheus and Grafana for monitoring

### Important Note About Repository Structure
The main branch contains the final, working version of the project.
During development, I worked under time constraints and experimented with multiple approaches, which resulted in: inconsistent branching strategy and partial implementations across different branches.
This repository reflects a learning process, and since then I have improved my workflow using structured branching, pull requests, issue tracking.

### Architecture
1. GitHub Actions triggers infrastructure provisioning
2. Terraform provisions VM (AWS and Azure)
3. Ansible configures the instace:
   - installs K3s
   - installs Helm
   - deploys ArgoCD
4. ArgoCD deploys Jenkins
5. Monitoring stack:
   - Prometheus
   - Grafana

### CI/CD Workflows
There are two GitHub Actions workflows:
1. AWS Infra -> provisions AWS infrastructure
2. Azure Infra -> provisions Azure infrastructure

Both follow the same steps:
1. Authenticate to cloud
2. Run Terraform
3. Configure VM via Ansible
4. Deploy Kubernetes stack

### Secrets Required
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SSH_PRIVATE_KEY
(similar equivalents for Azure)

#### Workflows are triggered manually from GitHub Actions by clicking "Run workflow"

### What gets deployed:
K3s Kubernetes cluster, ArgoCD, Jenkins, Prometheus, Grafana (all services are exposed via LoadBalancer)
