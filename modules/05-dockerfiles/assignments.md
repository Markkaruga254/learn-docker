# Module 05 Assignments

**A5.1: Containerize a Python script.** Write a Dockerfile for a script that prints your name and the current date. Use WORKDIR, COPY, and `ENTRYPOINT`+`CMD` so the name can be overridden at runtime.

**A5.2: Containerize `starter/app.py`.** Slim base, non-root user is *optional* here (required in Module 09), `EXPOSE 8000`, `HEALTHCHECK` optional. Run with `-p 8000:8000`.

**A5.3: Shrink it.** Take the `app:ubuntu` image and get it under 150 MB without changing behavior. Record each change and the new size.

**A5.4: Cache detective.** Given any Dockerfile of yours, list every layer and say which would rebuild if you change (a) one line of source, (b) `requirements.txt`, (c) the base image tag.

**A5.5: Explain:** (a) CMD vs RUN, (b) COPY vs ADD, (c) ENV vs ARG, (d) shell vs exec form.

**A5.6 (stretch):** Write a Dockerfile for any small app in a language you know (Node, Go, Java). Run it. Share it in your fork's `showcase/`.
