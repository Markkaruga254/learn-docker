# Module 05: Dockerfiles & custom images

**Video:** 3:22 to 4:36 (VS Code + Docker extension, Dockerfiles, layers, CMD vs RUN, EXPOSE, COPY)

## Objectives
- Write Dockerfiles using FROM, RUN, CMD, ENTRYPOINT, COPY, WORKDIR, ENV, ARG, LABEL, EXPOSE.
- Explain build time vs runtime and image layers and the build cache.
- Reduce image size and speed up rebuilds.
- Know the CMD vs ENTRYPOINT and COPY vs ADD differences.

## Concepts
- A Dockerfile is a recipe; each instruction creates a **read-only layer**. Unchanged layers are reused from cache.
- **Build time:** RUN, COPY, ADD. **Runtime:** CMD, ENTRYPOINT.
- Only the **last** CMD takes effect. `EXPOSE` is metadata, not publishing.
- The **build context** (the `.` in `docker build -t x .`) is the only thing COPY can see.
- File must be named exactly `Dockerfile` (capital D, no extension) or pass `-f`.

Cheat sheet: [dockerfile](../../cheatsheets/dockerfile.md)

## Starter files
`starter/app.py` (tiny HTTP server on port 8000), `starter/cache-demo/` (for the caching lab).
