#!/usr/bin/env bash
#
# Run after Docker build process has finished, and runtime configuration begins.

# Create virtualenv from requirements.txt.
#
# NOTE: I tried to create this via Dockerfile, but the directory keeps
# disappearing. I'm not sure why. Tutorial installs a bunch of new dependencies,
# and I'm using PostgreSQL 12.x which at least breaks SQLAlchemy version b/w
# tutorial, so I need to stand up infra idempotently, which means I need this
# part working idempotently.

echo "Creating virtualenv as $(whoami)." >> /tmp/log.txt
mkdir -p /root/env
python3 -m venv /root/env

echo "Installing requirements with python3 as $(which python3)." >> /tmp/log.txt

source /root/env/bin/activate && \
    pip3 install wheel && \
    pip3 install -r /root/requirements.txt

echo "\n" >> /tmp/log.txt
echo "Running tests." >> /tmp/log.txt
# Can't redirect python3 stdout to file w/o source mutation.

echo "\n" >> /tmp/log.txt
echo "Running migration." >> /tmp/log.txt

# This section of code apparently needs to be run manually, not sure why it
# doesn't work while scripted but I copied and pasted this into the Docker
# context and the PostgreSQL instance migrated successfully.
source /root/env/bin/activate && \
    PGPASSWORD=postgres python3 /root/manage.py create_db || true && \
    PGPASSWORD=postgres python3 /root/manage.py db init || true && \
    PGPASSWORD=postgres python3 /root/manage.py db migrate

# Start PostgreSQL instance.
service postgresql start

# Keep the container running.
tail -f /dev/null
