#!/usr/bin/env bash

cp ~/.cargo/bin/dotter .
chmod +x ./dotter
cp -v ~/.config/alacritty.yml alacritty
cp -v ~/.aliases aliases
cp -v ~/.config/kitty/kitty.conf kitty
cp -v ~/.config/mako/config mako
cp -v ~/.config/starship.toml starship
cp -v ~/.config/topgrade.toml topgrade
cp -v ~/.config/fish/config.fish fish
cp -v ~/.config/zellij/config.yaml zellij
cp -v ~/.config/sway/config sway
cp -v ~/.config/waybar/config waybar
cp -v ~/.config/waybar/style.css style
./dotter -V
./dotter
