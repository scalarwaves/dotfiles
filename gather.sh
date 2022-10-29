#!/usr/bin/env bash

echo ".-=gathering dotfiles=-."
echo ".-=gathering bat=-."
cp -R ~/.config/bat ~/dotfiles/
echo ".-=gathering bottom=-."
cp -R ~/.config/bottom ~/dotfiles/
echo ".-=gathering calcurse=-."
cp -R ~/.config/calcurse ~/dotfiles/
echo ".-=gathering fish=-."
cp -R ~/.config/fish ~/dotfiles/
echo ".-=gathering foot=-."
cp -R ~/.config/foot ~/dotfiles/
echo ".-=gathering helix=-."
cp -R ~/.config/helix ~/dotfiles/
echo ".-=gathering himalaya=-."
cp -R ~/.config/himalaya ~/dotfiles/
echo ".-=gathering hyprland=-."
cp -R ~/.config/hypr ~/dotfiles/
echo ".-=gathering kitty=-."
cp -R ~/.config/kitty ~/dotfiles/
echo ".-=gathering macchina=-."
cp -R ~/.config/macchina ~/dotfiles/
echo ".-=gathering mako=-."
cp -R ~/.config/mako ~/dotfiles/
echo ".-=gathering micro=-."
cp -R ~/.config/micro ~/dotfiles/
echo ".-=gathering nwg-suite=-."
cp -R ~/.config/nwg* ~/dotfiles/
echo ".-=gathering ranger=-"
cp -R ~/.config/ranger ~/dotfiles/
echo ".-=gathering rofi=-."
cp -R ~/.config/rofi ~/dotfiles/
echo ".-=gathering sway=-."
cp -R ~/.config/sway* ~/dotfiles/
echo ".-=gathering waybar=-."
cp -R ~/.config/waybar ~/dotfiles/
echo ".-=gathering xplr=-."
cp -R ~/.config/xplr ~/dotfiles/
echo ".-=gathering zathura=-."
cp -R ~/.config/zathura ~/dotfiles/
echo ".-=gathering zellij=-."
cp -R ~/.config/zellij ~/dotfiles/
cp ~/.cargo/bin/dotter .
chmod +x ~/dotfiles/dotter
~/dotfiles/dotter -V
# ~/dotfiles/dotter -v