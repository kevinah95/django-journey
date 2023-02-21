#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing the latest version of poetry..."
export POETRY_HOME="$(pwd)/.poetry"
python3 install-poetry.py --version 1.2.0

echo "$POETRY_HOME/bin/poetry --version"

poetry install

python manage.py migrate