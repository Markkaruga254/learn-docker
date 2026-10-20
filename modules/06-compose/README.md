# Module 06: Docker Compose

**Video:** 3:04 to 3:22 (intro, workflow) and 4:36 to 4:54 (configuration lab)

## Objectives
- Describe multi-container apps in one `docker-compose.yml`.
- Use services, ports, environment, env_file, volumes, networks, depends_on, healthchecks, restart policies.
- Operate a stack: up/down/ps/logs/exec/config.
- Understand that Compose creates a default network where **service names are DNS names**.

## Concepts
- Compose = declarative desired state for a set of containers, networks and volumes.
- Project name defaults to the directory name (`<dir>_default` network).
- `depends_on` orders **startup**, not readiness. Use `condition: service_healthy` with a healthcheck.
- YAML: spaces only, consistent indentation. Check with `docker compose config`.

Cheat sheet: [compose](../../cheatsheets/compose.md)
