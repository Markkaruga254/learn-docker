# Module 01 Solutions

## Quiz
1. Root can do anything, including closing the account; MFA protects against stolen passwords.
2. Call AWS APIs (here, register with Systems Manager) using temporary credentials, with no keys stored on disk.
3. `enable` makes it start at boot; `start` only starts it now.
4. apt verifies packages are really from Docker (integrity/authenticity).
5. `docker info`.
6. The instance has the SSM role attached; the SSM agent is running/registered (reboot after attaching); the instance has outbound internet/VPC endpoints.
7. Anything you publish later is exposed to the whole internet and attackers scan constantly.
8. `docker version` = client and daemon details; `docker -v` = client version string only.
9. It changes unless you attach an Elastic IP.
10. A `.pem` private key; `chmod 400` (owner read-only).

## Assignments
- A1.4: (a) apt checks signatures against the key to detect tampering; (b) it auto-starts the daemon on boot; (c) the daemon runs as root, and group members can ask it to mount the host filesystem into a container.
