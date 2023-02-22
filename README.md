# DJANGO-JOURNEY

This is my django journey based on the book *Django for Beginners Build websites with Python Django 4.0 (by William Vincent)*

## Deployment checklist

The apps in this repository are using [Render Web Services](https://render.com/).

I am deploying the apps configuring the infrastructure as code ([IaC](https://render.com/docs/infrastructure-as-code)) using a [Render Blueprint](https://render.com/docs/blueprint-spec).

In every chapter I followed these steps:

1. Edit `django_project/settings.py` and find the declaration of the `SECRET_KEY` setting:
    ```python
    # Don't forget to import os at the beginning of the file
    import os
    ```

    ```python
    # SECURITY WARNING: keep the secret key used in production secret!
    SECRET_KEY = os.environ.get('SECRET_KEY', default='your secret key')
    ```
2. Edit the declaration of the `DEBUG` setting:
    ```python
    DEBUG = 'RENDER' not in os.environ
    ```

3. When `DEBUG = False`, Django will not work without a suitable value for `ALLOWED_HOSTS`. You can get the name of your web service host from the `RENDER_EXTERNAL_HOSTNAME` environment variable, which is automatically set by Render.

    ```python
    ALLOWED_HOSTS = []

    # For Render deploy
    RENDER_EXTERNAL_HOSTNAME = os.environ.get("RENDER_EXTERNAL_HOSTNAME")
    if RENDER_EXTERNAL_HOSTNAME:
        ALLOWED_HOSTS.append(RENDER_EXTERNAL_HOSTNAME)
    ```
4. Add `gunicorn` dependency:

    ```bash
    $ poetry add gunicorn
    ```

5. Create a `build.sh` file. At this moment I use the last version of poetry and I need to updete it on Render:
    
    ```bash
    #!/usr/bin/env bash
    # exit on error
    set -o errexit

    echo "Installing the latest version of poetry..."

    pip install --upgrade pip

    pip install poetry==1.2.0

    rm poetry.lock

    poetry lock

    python -m poetry install

    python manage.py migrate
    ```

6. Add another web service to `render.yaml` file. Change `<<name>>` and `<<rootdir>>` variables:

    ```yaml
    services:
      - type: web
        name: <<name>>
        env: python
        region: oregon
        plan: free
        rootDir: <<rootdir>>
        buildCommand: "./build.sh"
        startCommand: "gunicorn django_project.wsgi:application"
        envVars:
        - key: PYTHON_VERSION
            value: 3.8.2
        - key: SECRET_KEY
            generateValue: true
        - key: WEB_CONCURRENCY
            value: 4
    ```

7. Remove packages include instruction in `pyproject.toml`:
    
    ```toml
        [tool.poetry]
        packages = [{include = "a_project"}]
    ```

    Removing the line with `packages = [{include = "a_project"}]` should avoid including the root project, because we are using a child folder as a root directory that we configured previously `rootDir: <<rootdir>>`.

## Roadmap

- [x] Chapter 1: Initial Set Up.
- [x] Chapter 2: Hello World App.
- [x] Chapter 3: Pages App.
- [x] Chapter 4: Message Board App.
- [ ] Chapter 5: Blog App.
- [ ] Chapter 6: Forms.
- [ ] Chapter 7: User Accounts.
- [ ] Chapter 8: Custom User Model.
- [ ] Chapter 9: User Authentication.
- [ ] Chapter 10: Bootstrap.
- [ ] Chapter 11: Password Change and Reset.
- [ ] Chapter 12: Email.
- [ ] Chapter 13: Newspaper App.
- [ ] Chapter 14: Permissions and Authorization.
- [ ] Chapter 15: Comments.
- [ ] Chapter 16: Deployment.