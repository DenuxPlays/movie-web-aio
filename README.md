# movie-web-aio (All-In-One)

A community project to set up movie-web with docker compose as easy as possible.<br>
It simply provides a docker image for hosting the static files and uses the official movie-web docker image for the
backend.<br>

**Note:**<br>
This project is designed to run behind a reverse proxy like nginx or traefik.<br>
It may work without a reverse proxy, but this is not tested or recommended.

## Features

- easy setup
- automatic updates
- fully self-hosted (even the proxy)
- configurable features (see [here](#deploy-command-documentation))
- pwa support (although not recommended | `--pwa` flag)
- proxy turnstile support (`--turnstile` flag)
- backend captcha support (`--captcha` flag)
- backend rate limit support (`--ratelimit` flag)

<details><summary>And much more:</summary>

- simple cli interface and fully documented
- automatic updates (via watchtower)
- fully alpine based images

</details>

## Usage

This guide assumes that you have docker and docker-compose installed.<br>

1. Clone this repository
2. execute `sh deploy.sh --init` to create the required files
3. change the `config.js` and `.env` file according to your setup
4. **optional** change the ports in the `compose.yml` file
5. set up a reverse proxy (see [here](#setting-up-a-reverse-proxy))
6. execute `sh deploy.sh --backend` to start the docker containers (
   see [here](#deploy-command-documentation))

## Setting up a reverse proxy

Please make sure to use https for all domains!<br>

### caddy

Add this to your caddyfile:

````caddyfile
https://movie-web.example.test:443 {
    reverse_proxy 127.0.0.1:8080
}

https://mw-backend.example.test:443 {
    reverse_proxy 127.0.0.1:8081
}

https://proxy.example.test:443 {
    reverse_proxy 127.0.0.1:3000
}
````

## Deploy Command Documentation

The `deploy.sh` command is a shell script used to set up and start the Docker Compose file for the movie-web project.
This script accepts several flags that control its behavior:

- `--init`: This flag initializes the setup by creating a `.env` and `config.js` file. These files should be modified
  according to your setup.

- `--all`: This flag starts all the Docker Compose services, including mw, backend, backend-db, proxy, and watchtower.

- `--backend`: This flag starts the Docker Compose with the backend service.

- `--static`: This flag starts the Docker Compose with the mw service. Use this if you just want to host the static
  site.

- `--proxy`: This flag starts the Docker Compose with the proxy service.

- `--watchtower`: This flag starts the Docker Compose with the watchtower service and applies the watchtower override.
  Allowing for automatic updates of the docker images.

- `--turnstile`: This flag enables the proxy turnstile feature. This feature is used to prevent unauthorized access to
  the proxy service.

- `--captcha`: This flag enables the backend captcha feature. This feature is used to prevent unauthorized access to the
  backend service.

- `--ratelimit`: This flag enables the backend rate limit feature. This feature is used to prevent abuse of the backend
  service.

- `--down`: This flag stops all the Docker Compose services.

You can combine these flags as needed. For example, you can use `sh deploy.sh --backend --proxy` to start the backend,
mw and proxy services.

### Recommended Setup

While it's possible to self-host all the services, we recommend self-hosting only the pwa and backend services. The
proxy service should be hosted on Cloudflare for better performance and security. To do this, you can use
the `--backend` flag when running the `deploy.sh` script, and set up the proxy service separately on
Cloudflare.
