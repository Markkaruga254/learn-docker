# Module 04: Data persistence: volumes & bind mounts

**Video:** 2:38 to 3:04

## Objectives
- Explain why container data is ephemeral (writable layer).
- Create, inspect, share, and remove named volumes.
- Use bind mounts for dev workflows and `:ro` for safety.
- Back up and restore a volume.
- Choose between volume, bind mount and tmpfs.

## Concepts
| | Named volume | Bind mount | tmpfs |
|---|---|---|---|
| Where | `/var/lib/docker/volumes/NAME/_data` | any host path | RAM |
| Managed by | Docker | You | Kernel |
| Best for | production data, databases | dev (live edit) | secrets/scratch that must not hit disk |
| Survives `docker rm` | yes | yes (it's your host files) | no |

Rule of thumb: **production state → named volume. Local code editing → bind mount.**

> The video demos MySQL; the `mysql` image **requires** a password variable (see CORRECTIONS.md). These labs use PostgreSQL.
