#!/bin/sh
#
# Run after Docker build process has finished, and runtime configuration begins.

# Keep the container running.
tail -f /dev/null
