#!/usr/bin/env bash
#
# Run after Docker build process has finished, and runtime configuration begins.

# Install persisted dependencies in venv at '/root/env'.
#
# NOTE: Must take place as one context since runtime context isn't preserved
# across different Docker build layers.
$(which python3.6) -m venv ${HOME}/env && \
    source ${HOME}/env/bin/activate && \
    pip3 install wheel && \
    pip3 install -r /src/requirements.txt

# Keep the container running.
tail -f /dev/null
