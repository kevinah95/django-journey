#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing the latest version of poetry..."
export POETRY_HOME="$(pwd)/.poetry"

pip install --upgrade pip

pip install poetry==1.2.0 --user

echo "poetry --version"

poetry install

python manage.py migrate