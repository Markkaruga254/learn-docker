# Module 08 Assignments

**A8.1:** Replace the starter site with a different static template (or your own portfolio) and repeat the pipeline end to end.

**A8.2:** Add a `.dockerignore` so `README.md`, `.git` and editor files never enter the image. Prove with `docker run --rm IMAGE ls -la /usr/share/nginx/html`.

**A8.3:** Add a custom `nginx.conf` (e.g. gzip, a `/healthz` location returning 200, custom 404 page) and mount or COPY it. Test it.

**A8.4:** Switch the base to `nginx:alpine`-based and compare size. Switch to run as non-root (hint: `nginxinc/nginx-unprivileged`, listens on 8080). Note what changes in `-p` and `EXPOSE`.

**A8.5:** Write a Compose file that runs the site on port 8080 with `restart: unless-stopped`.
