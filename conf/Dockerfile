# Docker image to wrap everything in one environment.

FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y upgrade

# Install runtime dependencies.
RUN apt-get install -y apt-utils

# Install Python dependencies.
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv

ENTRYPOINT [ "/app/entrypoint.sh" ]
