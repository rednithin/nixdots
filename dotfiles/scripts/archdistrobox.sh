#!/usr/bin/env bash

# This script is meant to be run after creating an arch distrobox environment
# Example: distrobox create --name myarch --image quay.io/toolbx/arch-toolbox:latest --nvidia

sudo pacman -Syyuu --noconfirm

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git ~
cd paru
makepkg -si

paru -S rustup libxkbcommon vulkan-tools nvidia-open zed vulkan-icd-loader nvidia-utils visual-studio-code-bin