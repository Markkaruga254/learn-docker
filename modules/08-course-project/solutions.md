# Module 08 Solutions

## Reference Dockerfile (build context = `starter/`)
```dockerfile
FROM nginx:1.27-alpine
COPY school-website /usr/share/nginx/html
EXPOSE 80
```

## Quiz
1. `/usr/share/nginx/html`.
2. A `school-website/` folder relative to the context root.
3. It proves the image is self-contained and the registry copy works, with no dependence on local source.
4. The site only works inside Docker's network; the host can't reach it via a published port.
5. Stop/remove the `v2` container and run `v1` again (tags are kept in the registry).
6. Tests the nginx configuration syntax.
7. `.git`, `README.md`, editor/OS files, anything not served.
8. Reproducible builds; upstream `latest` can change under you.

## A8.3 sample nginx.conf (COPY to `/etc/nginx/conf.d/default.conf`)
```nginx
server {
  listen 80;
  root /usr/share/nginx/html;
  gzip on;
  location /healthz { return 200 "ok\n"; add_header Content-Type text/plain; }
  location / { try_files $uri $uri/ =404; }
}
```
