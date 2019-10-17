#!/usr/bin/env bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"
export DB="main"

psql --dbname="$DB" <<- EOSQL
    DROP TABLE IF EXISTS LOCKING;
    DROP TYPE IF EXISTS lock_mode;
    CREATE TYPE lock_mode AS ENUM ('r', 'w');

    CREATE TABLE LOCKING (
      lock_name varchar(100) NOT NULL,
      mode lock_mode,
      stamp bigint,
      app_id integer,
      created timestamp,
      PRIMARY KEY (lock_name, mode, stamp, app_id)
    );
EOSQL
