# flask_jwt_tutorial_1

Tutorial: https://realpython.com/token-based-authentication-with-flask/

## Get started

1.  Execute `bash src/run.sh`.

2.  Move into Docker container environment by running `docker exec -it
    flask_jwt_tutorial_1 bash`.

3.  In the Docker container, start Python environment by running `source
    /root/env/bin/activate`.

4.  In order to access the live PostgreSQL container, run command
    `PGPASSWORD=postgres psql -h localhost -U postgres`. Cannot just use `psql`
    since Docker container bridges over network, and doesn't have local
    `/var/run/postgresql/.s.PGSQL.$PORT`.
