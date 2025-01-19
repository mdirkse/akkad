#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

nixos-rebuild switch --flake ".?submodules=1#pi"  --target-host maarten@akkad --use-remote-sudo --verbose
