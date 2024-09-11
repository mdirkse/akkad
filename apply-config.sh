#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

git pull origin main --recurse-submodules && sudo nixos-rebuild switch --flake ".?submodules=1#pi"
