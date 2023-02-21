#!/usr/bin/env bash
# exit on error
set -o errexit

export POETRY_HOME=/opt/poetry
python3 -m venv $POETRY_HOME
$POETRY_HOME/bin/pip install poetry==1.2.0
$POETRY_HOME/bin/poetry --version

$POETRY_HOME/bin/poetry install

python manage.py migrate