# flask_jwt_tutorial_1

Tutorial: https://realpython.com/token-based-authentication-with-flask/

## Get started

1.  Execute `bash src/run.sh`.

2.  Move into Docker container environment by running `docker exec -it
    flask_jwt_tutorial_1 bash`.

3.  Run `source /app/manual.sh` to run manual steps within Docker container and
    merge parent/child `bash` contexts.

## Other steps

-   In the Docker container, start Python environment by running `source
    /root/env/bin/activate`.

-   In order to access the live PostgreSQL container from the host, run command
    `psql -h localhost -U postgres`. Cannot just use `psql`
    since Docker container bridges over network, and doesn't have local
    `/var/run/postgresql/.s.PGSQL.$PORT`.

-   In order to run tests for the Python API, run command `source /app/manual.sh
    && python3 /root/manage.py test`.
