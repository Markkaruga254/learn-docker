# Docker Mastery: a hands-on, end-to-end Docker course repo

A practice-first companion to the freeCodeCamp video
**"Learn Docker – Full DevOps Course for Deploying Containerized Apps"** (by DolfinEd, ~6h20m):
<https://youtu.be/rjjES5IsPdg>

The video teaches the fundamentals. This repo turns them into **deliberate practice**: labs you
type yourself, break-and-fix exercises, assignments, quizzes, three tiered capstones and a final
practical exam. It also adds a **production-practices module** (multi-stage builds, non-root users,
scanning, CI/CD) because the video stops at the basics and a job-ready Docker skillset needs more.

> Not affiliated with freeCodeCamp or DolfinEd. All labs, exercises and text here are original;
> they follow the video's chapter order. Watch the video for the instructor's walkthroughs.

## Who this is for
Beginners to Docker who are comfortable with Linux terminal basics (cd, ls, cat, nano/vim).
Finish everything and you can containerize an app, wire services together, persist data, publish
images, and ship them securely through a pipeline.

## How to use this repo
1. Watch the matching video chapters (timestamps are in each module README).
2. Read the module README, then do `labs.md` **by typing every command yourself**. Do not copy-paste.
3. Predict output *before* you press Enter. Write down surprises.
4. Do `assignments.md` **before** opening `solutions.md`.
5. Take `quiz.md` closed-book. Check answers in `solutions.md`.
6. Tick the module off in [ROADMAP.md](ROADMAP.md).
7. Finish with the capstones and the [final exam](assessment/final-exam.md), then fill in the
   [confidence matrix](CONFIDENCE-MATRIX.md) honestly.

## Modules
| # | Module | Video timestamps | Est. time |
|---|--------|------------------|-----------|
| 00 | [Foundations: VMs vs containers, architecture](modules/00-foundations) | 0:00 to 0:53 | 3 h |
| 01 | [Environment setup: AWS EC2 + install Docker](modules/01-environment-setup) | 0:53 to 1:42 | 3 h |
| 02 | [Core CLI and container lifecycle](modules/02-core-cli) | 1:42 to 2:08 | 4 h |
| 03 | [Networking](modules/03-networking) | 2:08 to 2:38 | 4 h |
| 04 | [Storage: volumes and bind mounts](modules/04-storage) | 2:38 to 3:04 | 4 h |
| 05 | [Dockerfiles and images](modules/05-dockerfiles) | 3:22 to 4:36 | 6 h |
| 06 | [Docker Compose](modules/06-compose) | 3:04 and 4:36 | 5 h |
| 07 | [Registries and the image lifecycle](modules/07-registry) | 4:54 to 5:12 | 3 h |
| 08 | [Course project: containerize a website](modules/08-course-project) | 5:12 to 6:20 | 3 h |
| 09 | [Production practices (beyond the video)](modules/09-production-practices) | not in video | 8 h |
| 10 | [Capstones (3 tiers)](modules/10-capstones) | n/a | 15 h |

Quick references live in [cheatsheets/](cheatsheets). Start with [docker-cli](cheatsheets/docker-cli.md).

## Ground rules
- **Cost safety:** if you use AWS, set a billing alert first and *stop your instance when you finish*.
- **Never put secrets in images, Dockerfiles or Git.** Module 09 shows the right way.
- **Clean up** after each module: `scripts/cleanup.sh`.
- Run `scripts/doctor.sh` any time something feels off.
- Read [CORRECTIONS.md](CORRECTIONS.md) for where this repo deliberately differs from the video.

## Repo layout
```
modules/NN-name/   README.md  labs.md  assignments.md  quiz.md  solutions.md  (+ starter/ files)
cheatsheets/       one-page references
assessment/        final practical exam
scripts/           doctor.sh (environment check), cleanup.sh (safe cleanup)
CORRECTIONS.md     fixes and caveats vs. the video / extracted notes
```
