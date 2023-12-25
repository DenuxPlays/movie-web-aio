#!/usr/bin/env sh

# prepare
set -e
WORK_DIR="$(pwd)"
cd "$(dirname "$0")"

profiles="" # space separated list of profiles to use
overrides="" # space separated list of overrides to use

# function to handle --init flag
handle_init() {
  echo "Creating .env file..."
  cp -n .env.dist .env

  echo "Creating config.js file..."
  cp -n config.js.dist config.js

  echo "Please change .env and config.js according to your setup"
  exit 0
}

# function to handle --all flag
handle_all() {
  profiles="${profiles} --profile all --profile test"
  overrides="${overrides} -f overrides/watchtower.compose.override.yml -f overrides/turnstile.compose.override.yml -f overrides/captcha.compose.override.yml -f overrides/ratelimit.compose.override.yml"
}

# function to handle --backend flag
handle_backend() {
  profiles="${profiles} --profile backend"
}

# function to handle --pwa flag
handle_pwa() {
  profiles="${profiles} --profile pwa"
}

# function to handle --proxy flag
handle_proxy() {
  profiles="${profiles} --profile proxy"
}

handle_test() {
  profiles="${profiles} --profile test"
}

handle_watchtower() {
  profiles="${profiles} --profile watchtower"
  overrides="${overrides} -f overrides/watchtower.compose.override.yml"
}

handle_turnstile() {
  profiles="${profiles} --profile proxy"
  overrides="${overrides} -f overrides/turnstile.compose.override.yml"
}

handle_captcha() {
  profiles="${profiles} --profile backend"
  overrides="${overrides} -f overrides/captcha.compose.override.yml"
}

handle_ratelimit() {
  profiles="${profiles} --profile backend"
  overrides="${overrides} -f overrides/ratelimit.compose.override.yml"
}

handle_down() {
  docker-compose -f compose.yml \
  -f overrides/watchtower.compose.override.yml \
  -f overrides/turnstile.compose.override.yml \
  -f overrides/captcha.compose.override.yml \
  -f overrides/ratelimit.compose.override.yml \
  --profile all \
  --profile test down
  exit 0
}

# parse command line arguments
for arg in "$@"
do
  case $arg in
    --init)
      handle_init
      ;;
    --backend)
      handle_backend
      ;;
    --all)
      handle_all
      ;;
    --pwa)
      handle_pwa
      ;;
    --proxy)
      handle_proxy
      ;;
    --test)
      handle_test
      ;;
    --watchtower)
      handle_watchtower
      ;;
    --turnstile)
      handle_turnstile
      ;;
    --captcha)
      handle_captcha
      ;;
    --ratelimit)
      handle_ratelimit
      ;;
    --down)
      handle_down
      ;;
    *)
      echo "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

profiles="${profiles#"${profiles%%[![:space:]]*}"}"
overrides="${overrides#"${overrides%%[![:space:]]*}"}"
echo "Starting docker compose with profiles: $profiles and overrides: $overrides"
# shellcheck disable=SC2086
docker-compose -f compose.yml $overrides $profiles up -d
# shellcheck disable=SC2086
docker-compose -f compose.yml $overrides $profiles logs -f

cd "${WORK_DIR}"