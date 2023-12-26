#!/usr/bin/env sh

# prepare
set -e
WORK_DIR="$(pwd)"
cd "$(dirname "$0")"
cd ..

version=$1

if [ -z "$version" ]
then
    echo "Version is empty"
    exit 1
fi

echo "Building pwa container"
docker build -f ./docker/pwa/Dockerfile ./docker/pwa -t denuxgit/mw-pwa -t denuxgit/mw-pwa:$version

echo "Building static container"
docker build -f ./docker/static/Dockerfile ./docker/static -t denuxgit/mw-static -t denuxgit/mw-static:$version

echo "Pushing pwa container"
docker push denuxgit/mw-pwa
docker push denuxgit/mw-pwa:$version

echo "Pushing static container"
docker push denuxgit/mw-static
docker push denuxgit/mw-static:$version

cd "${WORK_DIR}"