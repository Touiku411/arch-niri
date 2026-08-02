#!/bin/bash
set -e

CURRENT_DIR=$HOME/arch-niri
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF

sudo systemctl enable -f sddm.service

echo -e "\nInstall successful"



