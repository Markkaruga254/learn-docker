# Module 01 Labs

## Lab 1.1: Protect the account and your wallet
1. Create the AWS account (free plan, basic support). **Check the current Free Tier terms.**
2. Enable **MFA on the root user**, then stop using root.
3. Billing → Budgets → create a **zero-spend or low budget alert** to your email.
4. IAM → Users → create `admin` with console access and `AdministratorAccess` (or something narrower), enable MFA, save credentials safely. Sign in as this user.

## Lab 1.2: Role so the instance can use Session Manager
IAM → Roles → Create role → trusted entity **EC2** → attach **`AmazonSSMManagedInstanceCore`** → name `IAM_ROLE_docker`.

## Lab 1.3: Launch the Docker host
EC2 → pick **one region and stay in it** (instances "disappear" when you switch regions).
| Setting | Value |
|---|---|
| Name | `Docker host` |
| AMI | Ubuntu Server 24.04 LTS |
| Type | `t2.micro` (or `t3.micro` if unavailable/free-tier eligible in your region) |
| Key pair | create `Docker_key` (RSA, .pem). Store it safely, never commit it |
| Public IP | Enabled |
| Security group `docker_SG` | **Inbound:** SSH 22 from **My IP**. (Labs add 80/8080 from **My IP** when needed.) |
| Storage | 8 to 30 GB gp3 |
| IAM instance profile | `IAM_ROLE_docker` |

**Why not "all traffic from anywhere"?** Anyone on the internet could reach every port you ever publish.
"My IP" costs nothing. If your IP changes, edit the rule.

## Lab 1.4: Three ways to connect
1. **Session Manager:** EC2 → instance → Connect → Session Manager. (If the button is greyed out: confirm the role is attached via Actions → Security → Modify IAM role, then reboot.)
2. **EC2 Instance Connect:** Connect → EC2 Instance Connect.
3. **SSH:**
```bash
chmod 400 Docker_key.pem
ssh -i Docker_key.pem ubuntu@<PUBLIC_IP>
```
Run `whoami`, `hostnamectl`, `uname -r` on each.

## Lab 1.5: Install Docker Engine (official apt repo)
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker
systemctl status docker --no-pager
```
**Write down:** what does each of the first 6 commands accomplish? (GPG key = package integrity; repo file = where apt finds Docker packages.)

## Lab 1.6: Verify and run without sudo
```bash
sudo docker run hello-world
sudo usermod -aG docker $USER && newgrp docker
docker run hello-world
docker version
docker -v
docker info | head -30
```
Read the `hello-world` output slowly; it narrates the client → daemon → registry flow.
From `docker info`: where is the Docker root dir? Which storage driver?

> **Security note:** members of the `docker` group can effectively become root on the host. Fine on a
> personal lab box; avoid on shared servers.

## Lab 1.7: Daily routine and cost control
1. Stop the instance (EC2 → Instance state → Stop) when done. Note the public IP changes on restart (unless you use an Elastic IP).
2. Start it, reconnect, confirm `docker ps -a` still lists your containers (disk persisted).
3. Check Billing/Cost Explorer once a week.

## Lab 1.8: Run the doctor
Clone this repo on the host and run `scripts/doctor.sh`. Fix any `[FAIL]`.
