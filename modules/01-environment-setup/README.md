# Module 01: Environment setup

**Video:** 0:53 to 1:42 (AWS free tier, Docker Desktop/VirtualBox alternatives, connecting, installing Docker on Ubuntu)

## Objectives
- Provision an Ubuntu 24.04 EC2 instance safely (budget alert, least-privilege access).
- Connect with Session Manager, EC2 Instance Connect and SSH.
- Install Docker Engine from Docker's official apt repository and verify it.
- Stop/start the instance as a daily cost-saving habit.

## Choose your path
| Path | When |
|---|---|
| **A. AWS EC2 (recommended)** | Closest to real jobs; works from any laptop |
| B. Docker Desktop (Win/macOS/Linux) | Quick local start; modules 02 to 08 work the same |
| C. Local Ubuntu VM (VirtualBox/VMware) | Offline, free |

Labs below cover Path A. For B/C do **Lab 1.5 only**, then `docker run hello-world`.

> Read [CORRECTIONS.md](../../CORRECTIONS.md) first: this module deliberately differs from the video's
> "open everything to the internet" shortcuts.

## Concepts
- **EC2**: virtual servers. **AMI**: the OS image. **Key pair**: SSH credentials. **Security group**: firewall.
- **IAM user/role**: identity and permissions. A **role** lets the instance itself talk to AWS services (here, SSM).
- **Session Manager (SSM)**: browser shell with no open SSH port.
- **systemd**: `systemctl status|enable|start|stop docker` manages the daemon.
