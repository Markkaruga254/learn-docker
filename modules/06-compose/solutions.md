# Module 06 Solutions

## Quiz
1. `compose.yaml` / `docker-compose.yml` in the current directory.
2. By service name via the project's default network DNS.
3. Not by default: only startup order. Use `condition: service_healthy` + `healthcheck`.
4. `stop` halts containers (they remain); `down` removes containers and networks.
5. `-v` (`--volumes`).
6. YAML forbids tabs for indentation.
7. Validates and prints the fully resolved configuration.
8. Compose interpolates `$VAR` itself; `$$` passes a literal `$` to the container's shell.
9. Restarts the container automatically unless you explicitly stopped it.
10. `.env` (kept out of Git) at minimum; better, a secrets mechanism (Module 09). Never in the image.

## A6.2
```yaml
services:
  cache:
    image: redis:7
    container_name: cache
    ports: ["6379:6379"]
    volumes: [redisdata:/data]
    networks: [appnet]
    restart: unless-stopped
volumes:
  redisdata:
networks:
  appnet:
```
Note: `ports: 6379:6379` publishes Redis to the whole host; in real life, omit it and keep Redis internal.
