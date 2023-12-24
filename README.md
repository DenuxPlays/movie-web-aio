# movie-web-aio (All-In-One)

A community project to set up movie-web with docker compose as easy as possible.<br>
It simply provides a docker image for hosting the static files and uses the official movie-web docker image for the
backend.<br>

**Note:**<br>
This project is designed to run behind a reverse proxy like nginx or traefik.<br>
It may work without a reverse proxy, but this is not tested or recommended.

## Usage

This guide assumes that you have docker and docker-compose installed.<br>

1. Clone this repository
2. **Optional:** modify the `compose.yml` file to your needs 
3. Run `docker-compose up -d` to start the containers

### Setting up a reverse proxy

Please make sure to use https for all domains!<br>

#### caddy

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
