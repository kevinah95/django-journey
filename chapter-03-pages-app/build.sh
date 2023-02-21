#!/usr/bin/env bash
# exit on error
set -o errexit

export POETRY_HOME="$(pwd)/.poetry"
python -m venv $POETRY_HOME
$POETRY_HOME/bin/pip install poetry==1.2.0 --user
$POETRY_HOME/bin/poetry --version

$POETRY_HOME/bin/poetry install

python manage.py migrate