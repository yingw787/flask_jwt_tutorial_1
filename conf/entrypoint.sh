#!/usr/bin/env bash
#
# Run after Docker build process has finished, and runtime configuration begins.

# Start PostgreSQL instance.
service postgresql start

# Keep the container running.
tail -f /dev/null
