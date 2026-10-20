# Module 09: Production practices (beyond the video)

The video gets you running containers. This module is what separates a demo from something you'd put
in front of users or show an employer.

## Objectives
- Build **small** images with multi-stage builds, `.dockerignore`, slim/distroless bases.
- Run as a **non-root** user, with a read-only filesystem and dropped capabilities.
- Add **healthchecks** and **restart policies**; set **resource limits**.
- Handle **secrets** without baking them into images.
- **Scan** images for vulnerabilities and act on results.
- Build, scan and push in **CI** (GitHub Actions).
- Pin versions and digests for reproducible builds.

## Concepts
| Practice | Why |
|---|---|
| Multi-stage build | Keep compilers/build tools out of the runtime image |
| Minimal base (slim, alpine, distroless) | Fewer packages → smaller attack surface, faster pulls |
| `USER` non-root | A container escape or app bug doesn't start as root |
| `.dockerignore` | Smaller context, no secrets/`.git` in the image |
| Pin tags/digests | Reproducible, auditable builds |
| Healthcheck | Orchestrators/Compose know when to restart or wait |
| `--memory`/`--cpus` | One noisy container can't starve the host |
| `--read-only`, `--cap-drop ALL`, `no-new-privileges` | Least privilege |
| Secrets via env/file/secret store at runtime | Image layers are forever and readable by anyone with the image |
| Scanning (Trivy/Scout) | Known CVEs in OS packages and dependencies |
| CI/CD | Every commit builds, tests, scans and publishes the same way |

> **Secrets:** anything in `ENV`, `ARG`, `COPY` or a `RUN` command ends up in image layers
> (`docker history` / `docker save` will reveal it). Deleting it in a later layer does not remove it.
