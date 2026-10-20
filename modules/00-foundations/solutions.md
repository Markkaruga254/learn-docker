# Module 00 Solutions

## Quiz
1. Faster CPUs.
2. The host kernel.
3. False. Containers share the host kernel; only user-space files are packaged.
4. Namespaces (isolation) and cgroups (resource limits).
5. `containerd` manages container lifecycle, image transfer, storage and networking; `runC` is the low-level runtime that actually spawns the container process via the kernel.
6. Image = read-only template; container = running (or stopped) instance of it.
7. Docker Hub (`docker.io`).
8. Any two: poor utilization, dependency conflicts, no isolation, slow to provision/move, high cost.
9. No guest OS to boot; it's starting a process.
10. The Docker daemon (`dockerd`) over its REST API (usually a Unix socket).

## Labs (key answers)
- 0.1: PID 1 is usually `systemd`/`init`. The parent of your shell is your terminal/SSH session process.
- 0.2: A new PID namespace plus a fresh `/proc` mount; only processes inside the namespace are visible. This is exactly the PID isolation a container gets.
- 0.3: The `memory` and `cpu` controllers.
- 0.5: VMs ≈ 40 GB RAM + 200 GB disk; containers ≈ 1 GB RAM + 1 GB disk (before shared layers).

## Assignments
- A0.3: 1 VM (stronger isolation) · 2 containers · 3 VM · 4 containers · 5 VM (a container needs a compatible kernel).
- A0.4: CLI → daemon; daemon checks local cache; no image → pulls from Docker Hub; containerd creates container; runC starts the process; `-d` returns control to the shell and prints the container ID.
