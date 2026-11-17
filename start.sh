#!/bin/sh
# Start Certimate (a PocketBase app) on Railway's PORT, with its data on /app/pb_data.
#
# CERTIMATE_ADMIN_USERNAME / CERTIMATE_ADMIN_PASSWORD are read by Certimate itself, and only
# on the very first start (when the database has no admin yet). Without them Certimate would
# create admin@certimate.fun / 1234567890, so refuse to start a fresh install without a password.
set -eu

PORT="${PORT:-8090}"
DATA_DIR="/app/pb_data"
mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_DIR/data.db" ] && [ -z "${CERTIMATE_ADMIN_PASSWORD:-}" ]; then
  echo "[start] CERTIMATE_ADMIN_PASSWORD is empty. Set it before the first start, so Certimate does not create its default admin password." >&2
  exit 1
fi

export CERTIMATE_ADMIN_USERNAME="${CERTIMATE_ADMIN_USERNAME:-admin@certimate.fun}"

exec /app/certimate serve --http "0.0.0.0:${PORT}" --dir "$DATA_DIR" "$@"
