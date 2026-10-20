# Module 09 Assignments

**A9.1: Hardened image checklist.** Take your Module 08 website and your Tier 2 API image. For each, tick: pinned tag · multi-stage if applicable · non-root · `.dockerignore` · healthcheck · no secrets · scanned with 0 critical findings. Write results to `HARDENING.md`.

**A9.2: Size budget.** Produce a Python or Node API image **under 150 MB** and a Go image **under 20 MB**. Record each change that helped.

**A9.3: Secret leak hunt.** I give you `docker history --no-trunc` output containing `ENV DB_PASSWORD=...`. Explain 3 ways it leaks and the fix. Then actually find a secret you planted in a layer using `docker save IMAGE | tar -x` and `grep`.

**A9.4: Limits experiment.** Run a container with `--memory 64m` and a program allocating memory (e.g. `python -c "x=bytearray(200*1024*1024)"`). Show exit code 137 and `OOMKilled=true` from `docker inspect`.

**A9.5:** Write a 1-page "Docker in production" policy for a team: base images, tags, users, secrets, scanning, updates, logging.

**A9.6 (stretch):** Sign an image with `cosign` or enable Docker Content Trust; write what it protects against.
