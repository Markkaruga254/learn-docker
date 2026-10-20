# Module 07 Solutions

## Quiz
1. `docker.io` (Docker Hub).
2. `latest`.
3. Nothing; it adds another name pointing at the same ID.
4. Tokens are revocable, scoped, and don't expose your account password.
5. A content hash of the image manifest; it's immutable, tags can be moved.
6. GHCR, ECR, GAR, ACR, self-hosted `registry:2`.
7. `bob/shop:v3`.
8. It's a moving target: unpredictable and not reproducible, so rollbacks are unclear.
9. `docker logout`.
10. The layers already existed in the registry; only the new manifest tag was pushed.

## A7.1
`nginx` → docker.io / library / nginx / latest · `bitnami/redis:7.2` → docker.io / bitnami / redis / 7.2 · `ghcr.io/acme/api:git-1a2b3c4` → ghcr.io / acme / api / git-1a2b3c4 · `localhost:5000/app:v1` → localhost:5000 / (none) / app / v1.

## A7.5
Redeploy the previous immutable tag (e.g. `1.0.0`) or digest; that's why release tags must never be overwritten.
