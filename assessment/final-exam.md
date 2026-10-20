# Final exam

**Format:** closed-book for Parts A and B (the CLI `--help` and official docs *are* allowed in Part C). Total 100 points; pass at 80.
Do Part C on a clean host with a timer: **45 minutes**.

## Part A: Written (30 pts, 2 each, 15 questions)
1. Explain how a container differs from a VM, and what the two share/don't share with the host.
2. What are namespaces and cgroups, and what does each do?
3. Name the components between `docker` CLI and the running process.
4. Why does `docker run -d ubuntu` exit immediately?
5. `docker run nginx -p 80:80`: what is wrong?
6. Why can't two containers on the default bridge reach each other by name, and how do you fix it?
7. What happens to data in the writable layer on `docker rm`?
8. When do you choose a bind mount over a named volume?
9. Explain image layers and how they make rebuilds fast.
10. Put these Dockerfile lines in the right order for best caching: `COPY . .`, `RUN pip install -r requirements.txt`, `COPY requirements.txt .`, `FROM python:3.12-slim`.
11. CMD vs ENTRYPOINT?
12. Does `EXPOSE` publish a port?
13. Why is `latest` risky in production?
14. Why shouldn't secrets be in `ENV` or `ARG`?
15. What does `depends_on: condition: service_healthy` need to work?

## Part B: Command writing (20 pts, 2 each, 10 tasks, no notes)
1. Run nginx detached as `web`, host port 9000 → container port 80, restart unless stopped.
2. Show the last 50 log lines of `web` and follow them.
3. Open a shell in `web`.
4. Print `web`'s IP address using inspect.
5. Create a user-defined network `app-net` and attach a new container `c1` (alpine, kept alive) to it.
6. Create volume `data`, mount it read-only into an alpine container, and list its contents.
7. Build the Dockerfile in the current directory as `me/app:1.2.0`, and also tag it `me/app:1.2`.
8. Push both tags, then pull `me/app:1.2.0` on another host.
9. Run a container with a 128 MB memory limit, read-only root filesystem, and all capabilities dropped.
10. Remove all stopped containers and dangling images.

## Part C: Troubleshoot a broken stack (30 pts)
Directory: `assessment/broken-stack/`. The goal: `docker compose up -d --build` then `curl localhost:8080` prints `ok from app`.
It has **4 bugs**. Fix them without rewriting the architecture. Log each bug: symptom, how you diagnosed it, fix. (6 pts per bug found+fixed, 6 pts for the log quality.)

## Part D: Build (20 pts)
In 60 minutes, from a blank folder, produce a Compose stack with: a tiny API of your choice (any language), a Redis cache, persistent Redis data, only the API's port published, healthchecks on both, credentials from `.env`, API as non-root. Prove it works and that restart keeps data.

## Scoring bands
| Score | Meaning |
|---|---|
| 90 to 100 | Confident, job-ready Docker fundamentals |
| 80 to 89 | Solid; revisit the weak modules |
| 60 to 79 | Redo labs for missed topics, retake in a week |
| < 60 | Repeat modules 02 to 06 labs without copy-paste |

Answers: [exam-solutions.md](exam-solutions.md) (open after finishing).
