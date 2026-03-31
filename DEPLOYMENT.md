# Deployment

This MCP server is deployed to the Pathfinder DO droplet as a Docker container.

## Quick Reference

| Field | Value |
|---|---|
| Droplet | `root@170.64.197.158` |
| Service name | `toggl` |
| URL | `https://toggl.mcp.pathfindermarketing.com.au/mcp` |
| Docker image | `australia-southeast1-docker.pkg.dev/pathfinder-383411/cloud-run-source-deploy/toggl-mcp:latest` |
| Env file | `/opt/pmin-mcpinfrastructure/env/toggl.env` |
| Full docs | [PM-Labs/pmin-mcpinfrastructure](https://github.com/PM-Labs/pmin-mcpinfrastructure) -> `docs/runbooks/toggl.md` |

## Deploy

```bash
gcloud builds submit --tag australia-southeast1-docker.pkg.dev/pathfinder-383411/cloud-run-source-deploy/toggl-mcp --project pathfinder-383411
ssh root@170.64.197.158 "cd /opt/pmin-mcpinfrastructure && docker compose pull toggl && docker compose up -d toggl"
```

## Rollback

```bash
ssh root@170.64.197.158 "cd /opt/pmin-mcpinfrastructure && docker compose stop toggl"
# Revert to previous image tag, then: docker compose up -d toggl
```

## Operational Docs

See [PM-Labs/pmin-mcpinfrastructure](https://github.com/PM-Labs/pmin-mcpinfrastructure) for:
- Architecture: `docs/ARCHITECTURE.md`
- Runbook: `docs/runbooks/toggl.md`
- Cron jobs: `docs/CRON-JOBS.md`
