BEGIN;
-- For vector operations
CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA extensions;
-- For queueing and processing jobs
-- (pgmq will create its own schema)
CREATE EXTENSION IF NOT EXISTS pgmq;
-- For async HTTP requests
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;
-- For scheduled processing and retries
-- (pg_cron will create its own schema)
CREATE EXTENSION IF NOT EXISTS pg_cron;
-- For clearing embeddings during updates
CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA extensions;
-- For index advisor
CREATE EXTENSION IF NOT EXISTS hypopg WITH SCHEMA extensions;

CREATE EXTENSION IF NOT EXISTS index_advisor WITH SCHEMA extensions;

COMMIT;