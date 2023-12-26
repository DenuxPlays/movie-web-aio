#!/usr/bin/env sh

# prepare
set -e
WORK_DIR="$(pwd)"
cd "$(dirname "$0")"
cd ..

echo "Building pwa container"
docker build -f ./docker/pwa/Dockerfile ./docker/pwa -t denuxgit/mw-pwa

echo "Building static container"
docker build -f ./docker/static/Dockerfile ./docker/static -t denuxgit/mw-static

echo "Building local-caddy container"
docker build -f ./docker/local-caddy/Dockerfile ./docker/local-caddy -t denuxgit/mw-local-caddy

cd "${WORK_DIR}"