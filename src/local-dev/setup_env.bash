#!/usr/bin/env bash
# This script sets up the local development environment.

echo "Creating Python virtual environment..."
python3 -m venv .venv

echo "Installing dependencies from requirements.txt..."
./.venv/bin/pip install -r requirements.txt

echo "Setup complete. To activate the environment, run:"
echo "Command: source .venv/bin/activate"

echo "Open Jupyter Lab"
echo "Command: jupyter lab 01-load-base-model.ipynb"
