# Module 02: Core CLI & container lifecycle

**Video:** 1:42 to 2:08 (pull, run, stop, inspect)

## Objectives
- Move a container through its lifecycle with `pull`, `create`, `start`, `stop`, `rm`, and know that `run` = pull + create + start.
- Use `-d`, `-it`, `--rm`, `--name`, `-p`, `-e` correctly and know why **flag position matters**.
- Prove that containers are ordinary Linux processes.
- Read logs, inspect JSON, exec into running containers, and clean up.
- Diagnose the 6 most common `docker run` failures.

## Lifecycle
```
image ──create──▶ Created ──start──▶ Running ──stop──▶ Exited ──rm──▶ (gone)
        └────────────── docker run does the first two (plus pull if needed) ─────────────┘
```
`docker exec` only works on **Running** containers.

## Key flags
| Flag | Meaning |
|---|---|
| `-d` | Detached (background) |
| `-it` | Interactive + TTY (a shell) |
| `--rm` | Auto-delete on exit |
| `--name` | Human name (must be unique) |
| `-p H:C` | Publish host port H to container port C |
| `-e K=V` | Environment variable |

See [docker-cli cheat sheet](../../cheatsheets/docker-cli.md).
