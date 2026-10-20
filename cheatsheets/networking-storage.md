# Networking & storage cheat sheet

## Network drivers
| Driver | Use |
|---|---|
| `bridge` | Default, single host. Default bridge `docker0` = `172.17.0.0/16`, **no name DNS** |
| user-defined bridge | Same, **plus DNS by container name** and better isolation |
| `host` | Share the host's network stack (no port mapping) |
| `none` | Loopback only |
| `overlay` | Multi-host (Swarm) |

```bash
docker network ls | inspect NET | create --subnet 172.20.0.0/16 NET | rm NET
docker network connect NET C | disconnect NET C
docker run -p 8080:80 nginx     # host 8080 -> container 80
docker port C
```

## Storage
| | Named volume | Bind mount |
|---|---|---|
| Location | `/var/lib/docker/volumes/NAME/_data` | any host path |
| Managed by | Docker | you |
| Use for | databases, production state | live code editing in dev |
| Syntax | `-v vol:/path` | `-v "$(pwd)":/path` |
| Read-only | `-v vol:/path:ro` | `-v "$(pwd)":/path:ro` |

```bash
docker volume create|ls|inspect|rm|prune
```
Container writable layers are **ephemeral**; anything not on a volume dies with the container.
