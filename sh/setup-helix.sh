#!/bin/sh
VERSION=24.07
ARCH=x86_64-linux
URL=https://github.com/helix-editor/helix/releases/download/$VERSION/helix-$VERSION-$ARCH.tar.xz

# Install Helix
echo "Installing Helix editor..."
wget -qO- $URL | sudo tar -x -J -C /opt
sudo ln -sf /opt/helix-$VERSION-$ARCH/hx /usr/local/bin/hx

# Python LSP
echo "Setup Python LSP..."
pip install python-lsp-server --quiet