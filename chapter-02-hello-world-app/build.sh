#!/usr/bin/env bash
# exit on error
set -o errexit

python -m pip install --user pipx

python -m pipx install poetry==1.2.0

echo "poetry --version"

poetry install

python manage.py migrate