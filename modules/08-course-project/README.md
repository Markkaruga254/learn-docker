# Module 08: Course project: containerize & deploy a website

**Video:** 5:12 to 6:20 (containerizing a website, AWS deployment, Git clone, Dockerfile, build, tag, push, verify)

## Scenario
A client gives you a static school website and wants it containerized, published to a registry, and
running on an AWS EC2 host. You'll deliver an image anyone can run with one command.

The video clones a sample site from GitHub. The original URL isn't preserved in the notes, so this repo
ships its own site in `starter/school-website/`. (Use any static template if you prefer.)

## Deliverables
1. `Dockerfile` that serves the site with nginx.
2. Image built locally and run on your Docker host.
3. Image tagged and pushed to Docker Hub as `YOUR_USER/school-website:v1`.
4. **Clean-host proof**: delete everything locally, then run the site straight from the registry.
5. A short `DEPLOY.md` with the commands and a screenshot of the live site.

## Concept recap
- nginx serves files from `/usr/share/nginx/html`.
- `COPY` brings the site into the image; `EXPOSE 80` documents the port; `-p` publishes it.
- Registries make an image portable: "it runs from Docker Hub on a machine that has never seen the source".
