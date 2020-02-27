#!/usr/bin/env bash
#
# Work that should be manually run by the user within the Docker environment,
# for one reason or another.

export PGPASSWORD=postgres

# Remove directory migrations before re-creating it to avoid errors.
rm -rf /root/migrations

# This section of code apparently needs to be run manually, not sure why it
# doesn't work while scripted but I copied and pasted this into the Docker
# context and the PostgreSQL instance migrated successfully.
. /root/env/bin/activate && \
    PGPASSWORD=postgres python3 /root/manage.py create_db || true && \
    PGPASSWORD=postgres python3 /root/manage.py db init || true && \
    PGPASSWORD=postgres python3 /root/manage.py db migrate

# Generate the server-side secret key, save to file, and export as env variable.
#
# This should be random, and only accessible server-side.
. /root/env/bin/activate && \
    python3 -c 'from base64 import b64encode; from os import urandom; random_bytes = urandom(64); token = b64encode(random_bytes).decode("utf-8"); print(token)' >> /tmp/secret.txt
echo 'Created secret key saved at /tmp/secret.txt'
export SECRET_KEY=$(cat /tmp/secret.txt)
