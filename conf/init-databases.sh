#!/usr/bin/env bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

psql <<- EOSQL
    CREATE DATABASE main;
    GRANT ALL PRIVILEGES ON DATABASE main TO postgres;

    CREATE DATABASE daedalus_locks_test;
    GRANT ALL PRIVILEGES ON DATABASE main_test TO postgres;
EOSQL
