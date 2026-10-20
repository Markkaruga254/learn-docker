# Tier 3 deployment runbook

This is a reference runbook for the secured API deployment exercise. It assumes the API image has already passed the CI scan and been published to GHCR. A real deployment still requires a staging host and a successful end-to-end rehearsal.

## 1. Before the first deployment

On the deployment host, create the application directory and place these files in it:

- `docker-compose.prod.yml`
- `nginx.conf`
- `.env` containing `POSTGRES_DB`, `POSTGRES_USER`, and `POSTGRES_PASSWORD`

Restrict the directory and `.env` permissions (for example, `chmod 600 .env`). Do not commit the real `.env` file or paste its contents into logs or issue reports.

Update the image reference in `docker-compose.prod.yml` from the `YOUR_GH_USER/YOUR_REPO` placeholder to the actual lower-case GHCR image path. The host must be able to pull that image; configure registry authentication using a least-privilege token or another supported credential mechanism.

From the trusted deployment workstation:

```bash
export DEPLOY_HOST=deploy@your-server
export APP_DIR=/opt/app
bash deploy.sh git-<full-commit-sha>
```

Use an immutable `git-<sha>` tag for repeatable deployments. Ensure SSH key authentication works before running the deployment.

## 2. Verify the release

After the command completes, verify the public health endpoint and inspect service status:

```bash
curl --fail --show-error http://your-server/health
ssh "$DEPLOY_HOST" "cd '$APP_DIR' && docker compose -f docker-compose.prod.yml ps"
ssh "$DEPLOY_HOST" "cd '$APP_DIR' && docker compose -f docker-compose.prod.yml logs --tail=100 api proxy"
```

Do not treat a successful SSH command alone as proof that the application is healthy. Confirm the health endpoint returns HTTP 200 and review the logs.

The deployment helper records the current image tag in `.last_deployed_tag` and, when a prior tag exists, copies it to `.previous_deployed_tag`.

## 3. Roll back

First inspect the recorded previous tag:

```bash
PREVIOUS_TAG=$(ssh "$DEPLOY_HOST" "cat '$APP_DIR/.previous_deployed_tag'")
printf 'Rollback target: %s\\n' "$PREVIOUS_TAG"
```

Verify that the value is a known-good immutable tag, then deploy it again:

```bash
bash deploy.sh "$PREVIOUS_TAG"
curl --fail --show-error http://your-server/health
```

If the previous-tag file does not exist (for example, on the first deployment), use a known-good `git-<sha>` from the release record. Do not guess a tag. After rollback, check the health endpoint, container status, and logs.

## 4. Rotate a database secret

1. Schedule a maintenance window and ensure the database has a verified backup.
2. Update the database credential in the server-side `.env` file using a secure session; never put the secret in a command-line argument or source control.
3. PostgreSQL does not automatically change an existing role password just because `POSTGRES_PASSWORD` changed in the environment. Apply the new password to the database role through an authenticated database session.
4. Restart/recreate the API with the updated environment and verify `/ready` and `/health`.
5. Confirm the old credential no longer works, then remove temporary secret copies from the workstation.

## 5. Troubleshooting

- **Health endpoint returns 502:** inspect proxy and API logs; confirm the API is attached to the frontend network and listening on port 8000.
- **`/ready` returns 503:** inspect database logs and verify `DB_HOST=db`, database name, username, and password. Confirm the database health check passes.
- **Image pull is denied:** verify the image path/tag and registry authentication on the host.
- **Compose config fails:** check that `IMAGE_TAG` is set, `.env` exists with the required variables, and the image path no longer contains placeholders.
- **Host is unreachable:** verify SSH connectivity and firewall rules. Expose only SSH from trusted source addresses and the required web ports (80/443); do not publish PostgreSQL.

## 6. Production checklist

- [ ] Test deployment and rollback on a staging host before production.
- [ ] Verify health endpoint, logs, and service status after each release.
- [ ] Keep immutable image tags and retain a known-good rollback target.
- [ ] Store credentials outside Git and rotate them through a controlled procedure.
- [ ] Restrict inbound network access and keep the database private.
- [ ] Pin GitHub Actions to full commit SHAs for production use and review scanner/action releases regularly.

**Scope note:** this runbook documents the expected operator workflow. It is not evidence that a real remote deployment or rollback has been performed; capture that evidence during the capstone exercise.
