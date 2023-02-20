#!/usr/bin/env bash
# exit on error
set -o errexit

poetry self update

poetry install

python manage.py migrate