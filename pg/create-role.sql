DO
$body$
BEGIN
    IF NOT EXISTS(
            SELECT *
            FROM pg_catalog.pg_user
            WHERE usename = 'ex')
    THEN
        CREATE ROLE ex WITH PASSWORD 'pass.word';
    END IF;
END
$body$;

ALTER ROLE ex NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION LOGIN;
