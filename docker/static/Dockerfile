FROM caddy:2.7.6-alpine

RUN apk update
RUN apk add --no-cache wget unzip

COPY --chmod=664 ./Caddyfile /etc/caddy/Caddyfile

ENV MW_VERSION=4.2.5

RUN mkdir -p /etc/caddy/movie-web

WORKDIR /etc/caddy/movie-web

RUN wget https://github.com/movie-web/movie-web/releases/download/$MW_VERSION/movie-web.zip

RUN unzip movie-web.zip -d /etc/caddy/movie-web

RUN rm movie-web.zip

RUN rm ./config.js
