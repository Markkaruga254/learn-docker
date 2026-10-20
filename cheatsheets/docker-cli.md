# Docker CLI cheat sheet

## Images
| Command | Purpose |
|---|---|
| `docker pull IMAGE[:TAG]` | Download an image (no tag = `latest`) |
| `docker images` / `docker image ls` | List local images (`-q` IDs only) |
| `docker build -t NAME:TAG .` | Build from `./Dockerfile` (`-f` to pick another file) |
| `docker history IMAGE` | Show layers and sizes |
| `docker tag SRC NEW` | Add another name to the same image ID |
| `docker rmi IMAGE` | Remove image (`-f` to force) |
| `docker image prune` / `-a` | Remove dangling / all unused images |

## Containers
| Command | Purpose |
|---|---|
| `docker run IMAGE` | pull + create + start |
| `docker run -d` | Detached (background) |
| `docker run -it IMAGE sh` | Interactive terminal |
| `docker run --rm` | Delete container when it exits |
| `docker run --name N` | Name it |
| `docker run -p HOST:CONT` | Publish a port |
| `docker run -e KEY=VAL` | Set an env var |
| `docker run -v SRC:DEST[:ro]` | Mount a volume or host path |
| `docker run --network NET` | Attach to a network |
| `docker run --memory 256m --cpus 0.5` | Resource limits |
| `docker create` / `start` / `stop` / `restart` | Lifecycle steps |
| `docker ps` / `ps -a` | Running / all containers |
| `docker exec -it C sh` | Shell in a **running** container |
| `docker logs -f --tail 50 C` | Follow logs |
| `docker inspect C` | Full JSON; `-f '{{.State.Pid}}'` for one field |
| `docker top C` / `docker stats` | Processes / live usage |
| `docker cp C:/path ./local` | Copy files in/out |
| `docker rm -f C` | Remove (force kills running) |
| `docker container prune` | Remove all stopped containers |

> **Flag placement:** options go **before** the image name. Everything after the image is passed to the
> container's command.

## System
`docker version` · `docker info` · `docker system df` · `docker system prune` (careful) · `docker events`

## Exit codes to recognise
`0` clean · `1` app error · `125` docker daemon/flag error · `126` command not executable · `127` command not found · `137` killed (SIGKILL / out of memory) · `143` SIGTERM
