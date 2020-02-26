# Docker image to wrap everything in one environment.

FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y upgrade

# Install runtime dependencies.
RUN apt-get install -y wget
RUN apt-get install -y unzip

# Install Python dependencies.
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv

# Download 'flask_jwt_auth' bundle.
RUN wget -qO- https://github.com/realpython/flask-jwt-auth/archive/1.0.0.zip >> ${HOME}/bundle.zip
RUN unzip ${HOME}/bundle.zip -d ${HOME}

# Install persisted dependencies in venv at '/root/env'.
#
# NOTE: Must take place as one context since runtime context isn't preserved
# across different Docker build layers.
RUN cd ${HOME}/flask-jwt-auth-1.0.0 && \
    python3.6 -m venv ${HOME}/env && \
    . ${HOME}/env/bin/activate && \
    pip3 install wheel && \
    pip3 install -r ./requirements.txt

ENTRYPOINT [ "/app/entrypoint.sh" ]
