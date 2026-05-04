# Deployment

This MCP server is deployed to the Pathfinder DO droplet as a Docker container,
built and pushed via GitHub Actions on every merge to `main`.

## Quick Reference

| Field           | Value |
|---|---|
| Service name    | `toggl` |
| URL             | `https://toggl.mcp.pathfindermarketing.com.au/mcp` |
| Container image | `ghcr.io/pmlabs-org/mcp-toggl:latest` |
| Env file        | `/opt/pmin-mcpinfrastructure/env/toggl.env` |
| Full docs       | [PM-Labs/pmin-mcpinfrastructure](https://github.com/PM-Labs/pmin-mcpinfrastructure) → `docs/runbooks/toggl.md` |

## Org-Level Secrets (set once on `pmlabs-org`, inherited by all repos)

| Secret           | Purpose                                   |
|---|---|
| `DEPLOY_HOST`    | Droplet IP or hostname                    |
| `DEPLOY_USER`    | SSH user                                  |
| `DEPLOY_SSH_KEY` | Private SSH key authorized on the droplet |

## Deploy (automated)

Every push to `main` triggers the CI/CD pipeline (`.github/workflows/ci.yml`):
tests → build image → push to GHCR → deploy to droplet.

## Manual deploy

```bash
ssh $DEPLOY_USER@$DEPLOY_HOST \
  "cd /opt/pmin-mcpinfrastructure && \
   docker compose pull toggl && \
   docker compose up -d --force-recreate toggl"
```

## Rollback

```bash
ssh $DEPLOY_USER@$DEPLOY_HOST \
  "cd /opt/pmin-mcpinfrastructure && \
   docker compose stop toggl && \
   docker tag ghcr.io/pmlabs-org/mcp-toggl:previous ghcr.io/pmlabs-org/mcp-toggl:latest && \
   docker compose up -d toggl"
```

## Operational Docs

See [PM-Labs/pmin-mcpinfrastructure](https://github.com/PM-Labs/pmin-mcpinfrastructure) for:
- Architecture: `docs/ARCHITECTURE.md`
- Runbook: `docs/runbooks/toggl.md`
- Cron jobs: `docs/CRON-JOBS.md`
