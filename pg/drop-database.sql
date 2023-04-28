-- Drop the database
-- The multiple lines below are necessary b/c the Postgresql server has a safety
-- check where it won't drop a DB if there are any existing connections. The
-- error message will look like:
-- ERROR:  database "ex" is being accessed by other users
-- DETAIL:  There are 10 other sessions using the database.
SELECT
   pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE
   pg_stat_activity.datname = 'example-db'
AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS example-db;
