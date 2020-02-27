#!/usr/bin/env bash
#
# Work that should be manually run by the user within the Docker environment,
# for one reason or another.

# This section of code apparently needs to be run manually, not sure why it
# doesn't work while scripted but I copied and pasted this into the Docker
# context and the PostgreSQL instance migrated successfully.
. /root/env/bin/activate && \
    PGPASSWORD=postgres python3 /root/manage.py create_db || true && \
    PGPASSWORD=postgres python3 /root/manage.py db init || true && \
    PGPASSWORD=postgres python3 /root/manage.py db migrate
