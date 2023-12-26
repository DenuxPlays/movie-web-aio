FROM caddy:2.7.6-alpine

RUN apk update
RUN apk add --no-cache wget unzip

COPY --chmod=664 ./Caddyfile /etc/caddy/Caddyfile

ENV MW_VERSION=4.1.2
ENV VITE_PWA_ENABLED=true

RUN mkdir -p /etc/caddy/movie-web

WORKDIR /etc/caddy/movie-web

RUN wget https://github.com/movie-web/movie-web/releases/download/$MW_VERSION/movie-web.pwa.zip

RUN unzip movie-web.pwa.zip -d /etc/caddy/movie-web

RUN rm movie-web.pwa.zip

RUN rm ./config.js
