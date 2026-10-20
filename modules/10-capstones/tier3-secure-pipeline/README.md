# Capstone Tier 3: Secured image, CI pipeline, deploy

**Brief:** Take the Tier 2 API and turn it into something a security-conscious team would accept:
hardened image, automated build/scan/publish on every push, and a repeatable deploy to a server.

## Requirements
**Image**
1. Multi-stage or minimal base; **non-root**; no secrets; pinned base (digest optional, bonus if documented).
2. Image size and vulnerability report recorded in `HARDENING.md` (before/after).
3. Runs with `--read-only`, `--cap-drop ALL`, `no-new-privileges`, memory/CPU/pids limits. Compose equivalents provided.

**CI (GitHub Actions)**
4. On every PR: build + scan; **fail** on CRITICAL vulnerabilities (with HIGH reported).
5. On merge to `main`: build, scan, push to a registry with tags `git-<sha>` and `main`; never overwrite release tags.
6. On Git tag `vX.Y.Z`: push `X.Y.Z`, `X.Y`, `X`.
7. Registry credentials only in repository secrets / OIDC; never in the repo.

**Deploy**
8. `docker-compose.prod.yml` references the **pushed image by tag/digest** (no `build:`).
9. A `deploy.sh` that, via SSH or SSM, pulls the new tag and restarts with zero manual steps.
10. A rollback command documented and tested.
11. Security group allows only 22 (My IP / or none if using SSM) and 80/443 as required.

**Docs**
12. `RUNBOOK.md`: deploy, rollback, rotate a secret, read logs, what to check when the health endpoint fails.

## Evidence to submit
Screenshot/log of: a failing PR (planted vulnerable dependency), a passing main build, the pushed tags, a successful deploy and a successful rollback.

## Stretch
SBOM generation (`syft`) · image signing (`cosign`) · deploy via GitHub Actions OIDC to AWS · ECR instead of Docker Hub · automatic dependency updates (Dependabot/Renovate).

## Reference
`reference/` holds a starting workflow, a prod Compose file and a deploy script. Treat versions in them as examples and
**check the current versions of Actions and tools**; pin Actions to a full commit SHA in real projects.
