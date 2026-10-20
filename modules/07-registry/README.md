# Module 07: Registries & the image lifecycle

**Video:** 4:54 to 5:12 (push/pull/tag)

## Objectives
- Read and write image names: `[registry/]namespace/repo[:tag]`.
- Authenticate, tag, push and pull with Docker Hub (and know the alternatives).
- Adopt a sane tagging strategy and avoid `latest` in deployments.
- Prove an image is deployable from a clean host.

## Concepts
- Default registry host `docker.io`; no tag means `:latest`.
- `docker tag` just adds another name to the **same image ID**.
- Tags are **mutable pointers**; the **digest** (`image@sha256:…`) is immutable.
- Use an **access token** (Docker Hub → Account settings → Personal access tokens) instead of your password.
- Alternatives: GitHub Container Registry (`ghcr.io`), AWS ECR, Google Artifact Registry, self-hosted `registry:2`.

## Tag strategy
| Tag | Use |
|---|---|
| `1.4.2` | exact, immutable release |
| `1.4` / `1` | moving minor/major |
| `git-<sha>` | exact commit; CI-friendly |
| `latest` | convenience only. **Never** deploy it |
