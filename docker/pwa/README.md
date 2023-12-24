# movie-web PWA docker image

This is a docker image for hosting the static files of movie-web as a PWA.<br>
This image is used in the [movie-web-aio](https://github.com/DenuxPlays/movie-web-aio) community project.
Go there for more information about this.

## Example Usage

### Docker Compose

```yaml
version: "3"
services:
  movie-web-pwa:
    image: denuxgit/mw-pwa:latest
    restart: unless-stopped
    volumes:
      - "./config.js:/etc/caddy/movie-web/config.js"
    ports:
      - "8080:80"
```

### Docker

```bash
docker run -d \
  --name=movie-web-pwa \
  -p 8080:80 \
  -v /path/to/config.js:/etc/caddy/movie-web/config.js \
  denuxgit/mw-pwa:latest
```
