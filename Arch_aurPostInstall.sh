#!/usr/bin/env bash

echo
echo "INSTALLING AUR SOFTWARE"
echo

cd "${HOME}"

echo "CLOING: AURIC"
git clone "https://github.com/rickellis/AURIC.git"


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


cd ${HOME}/AURIC
chmod +x auric.sh

for PKG in "${PKGS[@]}"; do
    ./auric.sh -i $PKG
done

echo
echo "Done!"
echo
