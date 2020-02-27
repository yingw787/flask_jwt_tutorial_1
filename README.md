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

## Notes

-   `requirements.txt` is outdated and dependencies have security
    vulnerabilities. However, dependency `Flask-Testing` as of February 27th,
    2020 is not available via PyPI with the version of Werkzeug (latest 1.0.0)
    on PyPI due to Werkzeug API change and lack of backporting:

    ```bash
    # old
    from werkzeug import cached_property

    # new, unaliased
    from werkzeug.utils import cached_property
    ```

    I didn't think it was worth the effort to `git` clone the package and
    install it, and I didn't want others to be limited by their architecture so
    I didn't pre-build any packages using `python3 setup.py {bdist_egg,
    bdist_wheel}`. Neither would be my ideal solution; ideally I will have a
    Bazel monorepo where I have all source dependencies locked down and would
    upgrade the unitary distribution at a commit level when necessary.
