#!/usr/bin/env sh

# prepare
set -e
WORK_DIR="$(pwd)"
cd "$(dirname "$0")"
cd ..

echo "Building pwa container"
docker build -f ./docker/pwa/Dockerfile ./docker/pwa -t denuxgit/mw-pwa

cd "${WORK_DIR}"