#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing the latest version of poetry..."

pip install --upgrade pip

pip install poetry==1.2.0

poetry env use .venv/bin/python

poetry install

python manage.py migrate