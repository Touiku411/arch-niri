#!/bin/bash

set -e
DOT_DIR="$HOME/arch-niri"

PKGS_PACMAN=(
    "niri"
    "sddm"
    "hyprlock"
    "kitty"
    "waybar"
    "swaybg"
    "swayidle"
    "rofi-wayland"
    "swaync"       
    "cava"     
    "fastfetch"
    "git" "base-devel"
    "pamixer"
    "brightnessctl"
    "grim"
    "slurp"
    "libnotify"
    "ttf-jetbrains-mono-nerd"
    "wlogout"
)
PKGS_AUR=(
)

sudo pacman -Syu --noconfirm

echo "install pacman pkgs..."
sudo pacman -S --noconfirm "${PKGS_PACMAN[@]}"

if ! command -v yay &> /dev/null; then
    echo "install yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$DOT_DIR"
fi

echo "install yay pkgs..."
yay -S --noconfirm "${PKGS_AUR[@]}"

echo "link..."
mkdir -p ~/.config
CONFIG_APPS=("niri" "hypr" "kitty" "waybar" "rofi" "swaync" "wlogout" "cava" "fastfetch" "fish")


for app in "${CONFIG_APPS[@]}"; do
    if [ -d "$DOT_DIR/.config/$app" ]; then
        rm -rf "$HOME/.config/$app"
        ln -snf "$DOT_DIR/.config/$app" "$HOME/.config/$app"
        echo "link $app"
    else
        echo "can not find $DOT_DIR/.config/$app... skip..."
    fi
done

echo "install sddm...."
cd "${DOT_DIR}/sddm"
chmod +x install.sh && ./install.sh
