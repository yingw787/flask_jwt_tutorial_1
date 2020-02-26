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

# Install Python dependencies.
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv

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

ENTRYPOINT [ "/app/entrypoint.sh" ]
