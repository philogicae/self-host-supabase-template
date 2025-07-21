BEGIN;
  -- Add pgvector extension
  CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA extensions;
COMMIT;