# Module 00: Foundations

**Video:** 0:00 to 0:53 (intro, why Docker, servers → VMs → containers, processes, architecture)

## Objectives
By the end you can:
- Name the 4 big benefits of Docker and give an example of each.
- Explain how physical servers → virtual machines → containers evolved, and what problem each solved.
- Explain why a container is "just a process" and what it shares with the host.
- Draw the Docker architecture (client, daemon, containerd, runC, images, containers, registry) from memory.

## Core ideas
**Four benefits**
1. *Reproducibility*: same image everywhere ("works on my machine" goes away).
2. *Dependency management*: each app carries its own runtime, so Python 2.7 and 3.12 coexist.
3. *Portability*: laptop, AWS, Azure, GCP, on-prem.
4. *Version control*: Dockerfile and Compose files are text, so they're reviewable and diff-able.

**Evolution**
| Era | Idea | Pain |
|---|---|---|
| Physical servers | One app per box | Costly, wasted capacity, dependency clashes, hard to move |
| Virtual machines | Hypervisor runs many guest OSes | Heavy: each VM has a full OS, boots in minutes, uses GBs |
| Containers | Isolated processes sharing the host kernel | Lightweight, start in ~ms, MBs |

**VM vs container**
| | VM | Container |
|---|---|---|
| Isolation unit | Whole OS (own kernel) | Process(es) (shared kernel) |
| Startup | Minutes | Milliseconds to seconds |
| Size | GBs | MBs |
| Overhead | Hypervisor + guest OS | Container engine |
| Isolation strength | Stronger | Weaker (shared kernel), hardened with extra controls |

**What makes a container?** Linux kernel features: *namespaces* (what a process can see: PIDs, network,
mounts, hostname) and *cgroups* (how much it can use: CPU, memory). Docker packages and automates them.

**Architecture**
```
docker CLI ──REST API──▶ dockerd (Docker daemon) ──▶ containerd ──▶ runC ──▶ container (Linux process)
                              │
                              └── pulls/pushes images ──▶ Registry (Docker Hub, private)
```
- **Image**: read-only layered template. **Container**: running instance of an image.
- **Registry**: stores images. Default is Docker Hub (`docker.io`).
- **Docker host**: machine where the daemon runs.

## Glossary
Containerization · Hypervisor · Guest OS · Kernel · Namespace · cgroup · Image · Layer · Container · Daemon · Registry · OCI

## Do next
`labs.md` → `assignments.md` → `quiz.md` (answers in `solutions.md`).
