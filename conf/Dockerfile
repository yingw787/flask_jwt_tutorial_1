# Docker image to wrap everything in one environment.

FROM ubuntu:18.04

# Set environment variable for non-interactivity
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y clean
RUN apt-get -y autoremove
RUN apt-get -y update && apt-get -y upgrade

# Install runtime dependencies.
RUN apt-get install -y apt-utils
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y gnupg
RUN apt-get install -y lsb-core

# Install PostgreSQL 12.x from PostgreSQL .deb package archive. Copied from
# 'github.com/yingw787/tinydevcrm-mvp'. Comments have been truncated.
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get -y update
RUN apt-get install -y postgresql-12
RUN apt-get install -y postgresql-client-12
RUN apt-get install -y postgresql-contrib-12
RUN apt-get install -y postgresql-server-dev-12

# Install Python backend.
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv

# Install persisted dependencies in venv at '/root/env'.
#
# NOTE: Must take place as one context since runtime context isn't preserved
# across different Docker build layers.
#
# NOTE: For some reason, the Docker volume isn't available at Docker build time.
# I also don't know how to copy a file outside of the directory of the
# Dockerfile to the container within the Dockerfile itself (i.e. not using
# `docker cp`). So I copied src/requirements.txt to conf/requirements.txt. This
# means that if requirements.txt change on host, it needs to be manually updated
# in this directory.
COPY requirements.txt /root

RUN python3.6 -m venv ${HOME}/env && \
    . ${HOME}/env/bin/activate && \
    pip3 install wheel && \
    pip3 install -r /root/requirements.txt

# Configure PostgreSQL. Copied from 'github.com/yingw787/tinydevcrm-mvp'.
# Comments have been truncated.
RUN apt-get install -y sudo

RUN service postgresql start && \
    sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

# Set up PostgreSQL user 'root'; 'root' has special privileges. Create user
# 'root' in order to avoid having to 'sudo su - postgres' when operating inside
# Docker container.
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE ROLE root SUPERUSER;" && \
    sudo -u postgres psql -c "ALTER ROLE root WITH LOGIN;" && \
    sudo -u postgres psql -c "CREATE DATABASE root;"

ENTRYPOINT [ "/app/entrypoint.sh" ]
