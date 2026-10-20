# Module 10: Capstones

Three projects, each harder. Build them in your own fork, commit as you go, and keep a `README.md` in
each project folder that someone else could follow. Reference solutions exist **only** for Tiers 2 and 3
(in `reference/`); try first, peek only when stuck, and write down what you peeked at.

| Tier | Project | Skills proven | Time |
|---|---|---|---|
| 1 | [Static site → registry → live](tier1-static-site) | Dockerfile, ports, registry, clean-host proof | 2 h |
| 2 | [API + database + reverse proxy](tier2-api-db-proxy) | Compose, networks, volumes, healthchecks, env/secrets | 6 h |
| 3 | [Secured image, CI pipeline, deploy](tier3-secure-pipeline) | Multi-stage, non-root, scan, CI/CD, deploy to EC2 | 7 h |

## Rubric (applies to all tiers; 100 points)
| Area | Points | Full marks means… |
|---|---|---|
| Works end to end | 30 | Fresh clone + documented commands → working app |
| Dockerfile quality | 20 | Pinned base, sensible layers, `.dockerignore`, small |
| Config & secrets | 15 | No secrets in Git/images; `.env.example` provided |
| Data & networking | 15 | Persistence proven; only needed ports published |
| Docs | 10 | README with prerequisites, run, test, teardown, troubleshooting |
| Operability | 10 | Healthchecks, restart policy, logs, limits |

Pass: **≥ 75 per tier.**
