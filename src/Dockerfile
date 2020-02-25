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

# Download 'flask_jwt_auth' bundle.
RUN wget -qO- https://github.com/realpython/flask-jwt-auth/archive/1.0.0.zip >> ${HOME}/bundle.zip
RUN unzip ${HOME}/bundle.zip

ENTRYPOINT [ "/app/entrypoint.sh" ]
