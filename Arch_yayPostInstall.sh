#!/usr/bin/env bash

echo
echo "INSTALLING YAY PKGMGR"
echo

cd "${HOME}" && mkdir "GitRepos" && cd "GitRepos"

echo "CLOING: YAY"
git clone "https://aur.archlinux.org/yay.git"


PKGS=(

    # SYSTEM UTILITIES ----------------------------------------------------

    'gtkhash'                   # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------------


    # UTILITIES -----------------------------------------------------------
    
    'keepass2'                # Password manager
    'slimlock'                  # Screen locker
    'oomox'                     # Theme editor

    # DEVELOPMENT ---------------------------------------------------------
    
    ' '    # Kickass text editor

    # MEDIA ---------------------------------------------------------------


    # POST PRODUCTION -----------------------------------------------------

    'peek'                      # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------------


    # THEMES --------------------------------------------------------------

    'gtk-theme-arc-git'
    'adapta-gtk-theme-git'
    'paper-icon-theme'
    'tango-icon-theme'
    'tango-icon-theme-extras'
    'numix-icon-theme-git'
    'sardi-icons'
)


cd ${HOME/GitRepos}/yay
makepkg -si && yay -Syy

for PKG in "${PKGS[@]}"; do
    sudo yay -S $PKG
done

echo
echo "Done!"
echo
