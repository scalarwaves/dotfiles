#!/usr/bin/env bash

echo ".-=installing dotfiles=-."
echo ".-=installing bat=-."
cp -R ./bat ~/.config/
echo ".-=installing bottom=-."
cp -R ./bottom ~/.config/
echo ".-=installing calcurse=-."
cp -R ./calcurse ~/.config/
echo ".-=installing fish=-."
cp -R ./fish ~/.config/
echo ".-=installing foot=-."
cp -R ./foot ~/.config/
echo ".-=installing helix=-."
cp -R ./helix ~/.config/
echo ".-=installing himalaya=-."
cp -R ./himalaya ~/.config/
echo ".-=installing kitty=-."
cp -R ./kitty ~/.config/
echo ".-=installing macchina=-."
cp -R ./macchina ~/.config/
echo ".-=installing mako=-."
cp -R ./mako ~/.config/
echo ".-=installing micro=-."
cp -R ./micro ~/.config/
echo ".-=installing nwg-suite=-."
cp -R ./nwg* ~/.config/
echo ".-=installing ranger=-."
cp -R ./ranger ~/.config/
echo ".-=installing rofi=-."
cp -R ./rofi ~/.config/
echo ".-=installing sway=-."
cp -R ./sway* ~/.config/
echo ".-=installing waybar=-."
cp -R ./waybar ~/.config/
echo ".-=installing xplr=-."
cp -R ./xplr ~/.config/
echo ".-=installing zathura=-."
cp -R ./zathura ./config/
echo ".-=installing zellij=-."
cp -R ./zellij ./config/
cp ~/.cargo/bin/dotter .
chmod +x ./dotter
./dotter -V
# ./dotter -v