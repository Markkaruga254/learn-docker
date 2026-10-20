# Troubleshooting cheat sheet

| Symptom | Likely cause | Check / fix |
|---|---|---|
| `Cannot connect to the Docker daemon` | Daemon stopped, or not in `docker` group | `systemctl status docker`; `sudo usermod -aG docker $USER` then re-login |
| `permission denied ... docker.sock` | Same | as above |
| `container name "/x" is already in use` | Old container exists | `docker rm -f x` |
| `port is already allocated` | Host port taken | `docker ps`; `ss -tulpn \| grep PORT`; pick another port |
| Container exits immediately | Main process ended/crashed | `docker logs C`; `docker inspect -f '{{.State.ExitCode}}' C` |
| `exec: ... not found` / exit 127 | Wrong CMD path or missing binary | `docker run --rm -it IMAGE sh` and look around |
| Site not reachable | Port not published, SG/firewall closed, app bound to 127.0.0.1 | `docker port C`; check security group; app must listen on `0.0.0.0` |
| Can't resolve service name | Default bridge, or different networks | use a user-defined network / Compose |
| Data vanished | No volume | mount a named volume |
| Build ignores changes | Cache | `docker build --no-cache .`; reorder Dockerfile |
| `COPY failed: file not found` | File outside build context or ignored | check path and `.dockerignore` |
| Compose YAML error | Tabs / bad indentation | `docker compose config` |
| Exit 137 | OOM-killed or SIGKILL | raise `--memory`; `docker inspect -f '{{.State.OOMKilled}}' C` |
| Disk full | Old images/volumes | `docker system df`; `docker system prune` |

**Debug ladder:** `docker ps -a` → `docker logs` → `docker inspect` → `docker exec -it C sh` → run the image with `sh` instead of its CMD.
