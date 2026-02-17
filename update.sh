#!/usr/bin/env bash
# 1. Update the flake lockfile
nix flake update

# 2. Try to build, but don't switch if it fails
# This prevents your system from trying to activate a broken build
sudo nixos-rebuild build --flake .#chill --cores 4

if [ $? -eq 0 ]; then
    echo "Build successful! Run 'sudo nixos-rebuild switch' to apply."
else
    echo "Build failed. Staying on current version."
fi
