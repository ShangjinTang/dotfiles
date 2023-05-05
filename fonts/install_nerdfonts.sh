#!/bin/bash

# Usage example: $0 RobotoMono FiraCode

INSTALLED=false
echo "Installing Nerd Fonts: $*"
for font in "$@"; do
    if [[ ! $(ls ~/.local/share/fonts/"${font}"NerdFont*) ]] &> /dev/null; then
        echo "Downloading https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/${font}.zip ..."
        wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/${font}.zip"
        echo "Downloading finished, unzipping to ~/.local/share/fonts ..."
        unzip -o "${font}".zip -d ~/.local/share/fonts
        echo "Unzipping finished, generate font cache ..."
        rm "${font}".zip
        INSTALLED=true
    else
        echo " - ${font} Nerd Font is already installed, skipping ..."
    fi
done

if $INSTALLED; then
    fc-cache -fv > /dev/null
    echo "Installing complete"
else
    echo "Nothing to do"
fi
