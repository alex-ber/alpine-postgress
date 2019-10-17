#!/usr/bin/env bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"
export DB="main"

psql --dbname="$DB" <<- EOSQL
    DROP TABLE IF EXISTS LOCKING_PERMITS;

    CREATE TABLE LOCKING_PERMITS (
      lock_name varchar(100) NOT NULL,
      mode lock_mode,
      permits integer CONSTRAINT positive_permist CHECK (permits>0),
      PRIMARY KEY (lock_name, mode)
    );

EOSQL
