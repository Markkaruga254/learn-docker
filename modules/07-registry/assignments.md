# Module 07 Assignments

**A7.1:** Decode these names into registry / namespace / repo / tag: `nginx`, `bitnami/redis:7.2`, `ghcr.io/acme/api:git-1a2b3c4`, `localhost:5000/app:v1`.

**A7.2:** Design a tagging scheme for a team shipping weekly. Write it in `TAGGING.md` (what's built from `main`, from release tags, from PRs; what gets deployed).

**A7.3:** Publish an image with `1.0.0`, `1.0`, `1`, and `git-<sha>` tags; show they point to one digest. Then push a new `1.0.1`, move `1.0` and `1`, leave `1.0.0` alone.

**A7.4:** Write `release.sh` that builds, tags (from a version argument), and pushes, failing on a dirty Git tree.

**A7.5:** Explain how you'd roll back a bad release using only tags.
