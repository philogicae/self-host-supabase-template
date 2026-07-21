# Self-Hosted Supabase Template

A convenient template for self-hosting a complete Supabase environment using Docker Compose. Includes all services needed to run a full-featured Supabase instance: **Postgres 17** (with `pgvector` for AI applications), **Auth** (GoTrue), **Storage** (with RustFS for S3-compatible object storage), **PostgREST**, **Realtime**, **Edge Functions**, **Studio**, and the **Kong** API gateway.

> All credit to [Supabase](https://github.com/supabase/supabase)

> Official Guide: [Self-Hosting](https://supabase.com/docs/guides/self-hosting/docker)

## Features

- **PostgreSQL 17** with `pgvector` extension enabled by default
- **RustFS** for local, S3-compatible object storage (replaces MinIO)
- **Asymmetric JWT auth (ES256)** with JWKS support and opaque API keys
- **Kong** API gateway with expression-based routing
- **Envoy** as an alternative API gateway (pre-configured, optional)
- **TLS proxy** support via Caddy or Nginx with automatic Let's Encrypt certificates
- **Multi-instance support** — run multiple Supabase stacks on the same server via `COMPOSE_PROJECT_NAME`
- **Utility scripts** for secret generation, key rotation, password management, and schema ownership
- **Comprehensive `.env.example`** with documented settings for OAuth, SAML SSO, MFA, and SMTP

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- `openssl` (for secret generation)

## Quickstart

1. **Clone the repository:**

```bash
git clone https://github.com/philogicae/self-host-supabase-template.git
cd self-host-supabase-template
```

2. **Copy the example environment file:**

```bash
cp .env.example .env
```

3. **Generate secrets and API keys:**

```bash
sh ./utils/generate-keys.sh
```

This generates all required secrets (`JWT_SECRET`, `ANON_KEY`, `SERVICE_ROLE_KEY`, database passwords, encryption keys, S3 credentials, etc.) and optionally writes them directly to your `.env` file. Review the `.env` file afterwards and adjust URLs, dashboard credentials, and any auth provider settings to your needs.

> **Asymmetric keys (optional):** To use ES256 asymmetric JWT auth with opaque API keys, also run:
>
> ```bash
> sh ./utils/add-new-auth-keys.sh
> ```
>
> This generates `JWT_KEYS`, `JWT_JWKS`, `SUPABASE_PUBLISHABLE_KEY`, and `SUPABASE_SECRET_KEY`. See the [Auth Keys guide](https://supabase.com/docs/guides/self-hosting/self-hosted-auth-keys) for details.

4. **Deploy the stack:**

```bash
./deploy.sh
```

This creates the necessary volume directories and starts all services in the background via Docker Compose.

5. **Access Supabase Studio:**

Open `http://localhost:8000` in your browser and log in with the `DASHBOARD_USERNAME` and `DASHBOARD_PASSWORD` from your `.env` file.

The REST API is available at `http://localhost:8000/rest/v1/` and the Auth API at `http://localhost:8000/auth/v1/`.

## Multi-Instance Support

To run multiple Supabase stacks on the same host, set a unique `COMPOSE_PROJECT_NAME` in each instance's `.env` file:

```env
COMPOSE_PROJECT_NAME=my-project-supabase
```

All container, volume, and network names are prefixed with this value, preventing conflicts between instances.

## TLS Proxy (HTTPS)

Optional Caddy and Nginx reverse proxy configurations with automatic Let's Encrypt certificates are included in `volumes/proxy/`. These are configuration templates — you'll need to wire them into your Docker Compose setup or run them standalone:

- **Caddy**: `volumes/proxy/caddy/Caddyfile` — automatic HTTPS with no extra setup
- **Nginx**: `volumes/proxy/nginx/supabase-nginx.conf.tpl` — uses Certbot for Let's Encrypt

Set `PROXY_DOMAIN` (and `CERTBOT_EMAIL` for Nginx) in your `.env` file. See the [HTTPS proxy guide](https://supabase.com/docs/guides/self-hosting/self-hosted-proxy-https).

## Utility Scripts

All scripts are in the `utils/` directory:

| Script                   | Description                                                                                     |
| ------------------------ | ----------------------------------------------------------------------------------------------- |
| `generate-keys.sh`       | Generate all secrets and legacy HS256 JWT API keys for a fresh installation                     |
| `add-new-auth-keys.sh`   | Generate ES256 asymmetric key pair, JWKS, and opaque API keys (requires `JWT_SECRET` in `.env`) |
| `rotate-new-api-keys.sh` | Rotate opaque API keys without changing the asymmetric key pair or JWT tokens                   |
| `db-passwd.sh`           | Update the Postgres database password across all services                                       |
| `reassign-owner.sh`      | Reassign ownership of public schema objects from `supabase_admin` to `postgres`                 |

## Project Structure

```
.
├── .env.example          # Example environment file — copy to .env and fill in
├── compose.yaml          # Docker Compose file defining all Supabase services
├── deploy.sh             # Deploy script (creates volumes + starts services)
├── reset.sh              # Reset script (stops containers, removes volumes, resets git state)
├── prepare_volumes.sh    # Creates volume directories (called by deploy.sh)
├── utils/                # Utility scripts for secret generation, key rotation, etc.
└── volumes/              # Initialization scripts and configuration files
    ├── api/              # Kong and Envoy API gateway configurations
    │   ├── envoy/        # Envoy proxy configs (cds.yaml, lds.template.yaml, envoy.yaml)
    │   ├── kong.yml      # Kong routing configuration
    │   └── kong-entrypoint.sh
    ├── db/               # Database init scripts (roles, JWT, webhooks, custom SQL)
    ├── functions/        # Edge function examples (hello, main)
    ├── logs/             # Vector log shipping configuration
    ├── pooler/           # Supavisor pooler configuration
    ├── proxy/            # TLS proxy configurations
    │   ├── caddy/        # Caddyfile for automatic HTTPS
    │   └── nginx/        # Nginx config template for Let's Encrypt
    ├── snippets/         # Custom SQL snippets (empty by default)
    └── storage/          # Storage volume (RustFS data)
```

## Reset

To completely reset the environment (stops containers, removes volumes, restores git state):

```bash
./reset.sh
```
