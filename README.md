# Self-Hosted Supabase Template

This repository provides a convenient template for self-hosting a complete Supabase environment using Docker Compose. It includes all the necessary services to run a full-featured Supabase instance, including the `database`, `authentication`, `storage`, and the `Supabase Studio UI`. This template comes with the `pgvector` extension enabled by default for AI applications and includes `minio` for local, S3-compatible object storage.

> All credit to [Supabase](https://github.com/supabase/supabase)

## Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started
To get your self-hosted Supabase instance up and running, follow these steps:

1.  **Clone the repository:**

```bash
git clone https://github.com/philogicae/self-host-supabase-template.git
cd self-host-supabase-template
```

2.  **Deploy the Supabase stack:**

Copy the `.env.example` file to `.env` and fill it with your own values.
Then run the `deploy.sh` script:
```bash
./deploy.sh
```
- This script will:
    - Create the necessary directories for the database and storage volumes.
    - Start all the Supabase services in the background using Docker Compose.

3.  **Access Supabase Studio:**

Once the services are running, you can access the Supabase Studio by opening your web browser and navigating to `http://localhost:3000`.

## Project Structure
- `.env.example`: An example environment file that you should copy to `.env` and fill with your own values.
- `compose.yaml`: The main Docker Compose file that defines all the Supabase services.
- `volumes`: Contains initialization scripts and configuration files for the various services.
- `deploy.sh`: A script to deploy the Supabase stack.
- `reset.sh`: A script to reset the Supabase environment by stopping containers, removing volumes, and resetting the git repository.
- `prepare_volumes.sh`: A script to create the necessary volume directories. Note that `deploy.sh` already performs this step.