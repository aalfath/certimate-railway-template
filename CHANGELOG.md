# Changelog

Breaking changes are listed first in each entry.

## 0.4.38 (2026-11-17)

- First release of the Railway template: Certimate v0.4.38 (`certimate/certimate:v0.4.38@sha256:175193844f59de2ea187b13c2f81ce23c1410dd6af0630a9e6434d1498a6e33b`).
- Listens on Railway's `PORT`, data on a volume at `/app/pb_data`, health check `/api/health`.
- First admin account from `CERTIMATE_ADMIN_USERNAME` and a generated `CERTIMATE_ADMIN_PASSWORD`; a fresh install without a password refuses to start.
