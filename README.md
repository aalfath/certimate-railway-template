# Certimate on Railway

This repo packages [Certimate](https://github.com/certimate-go/certimate), an open-source, self-hosted tool that issues, deploys, renews and monitors SSL/TLS certificates (ACME) through a visual workflow editor, as a one-click Railway template.

## What the template deploys

- **Certimate v0.4.38**, built from the official image `certimate/certimate:v0.4.38@sha256:175193844f59de2ea187b13c2f81ce23c1410dd6af0630a9e6434d1498a6e33b` (pinned by version and digest).
- One service with a public Railway domain, listening on Railway's `PORT`, with the health check on `/api/health`.
- One volume at `/app/pb_data`, which holds Certimate's SQLite database, settings, certificates and logs.

There is no separate database: Certimate is built on PocketBase and stores everything in SQLite on the volume.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `CERTIMATE_ADMIN_USERNAME` | (you enter it) | Email of the first admin account. Used only on the first start. |
| `CERTIMATE_ADMIN_PASSWORD` | `${{secret(24)}}` | Password of the first admin account, generated per deploy. Used only on the first start. Read it in the service's Variables tab. |
| `PORT` | `8090` | Port Certimate listens on. |

The start script refuses to initialise a new install without `CERTIMATE_ADMIN_PASSWORD`, so Certimate never creates its built-in default admin password (`1234567890`). After the first start, change the admin email and password in Certimate's settings; changing the variables later has no effect.

DNS-provider and deployment credentials (Cloudflare, Aliyun, SSH hosts and so on) and notification channels are added in Certimate's UI, not as Railway variables.

## Files

- `Dockerfile`: the pinned upstream image plus `start.sh`.
- `start.sh`: starts `certimate serve` on `0.0.0.0:$PORT` with `--dir /app/pb_data`.
- `docker-compose.test.yml`: local test only; Railway doesn't use it.

## Updates

Deployers of the template get an "update available" notice in Railway when this repo's `main` branch changes. Each version is listed in [CHANGELOG.md](CHANGELOG.md), with breaking changes first. Read it before you apply an update, and keep a backup of the volume (Railway volume backups, or Certimate's own backup in its settings).
