#!/usr/bin/env zsh
source ~/.zshrc
set -e

echo "=== uv ==="
uv self update
uv tool upgrade --all

echo ""
echo "=== rustup ==="
rustup update

echo ""
echo "=== zinit self-update + plugin update ==="
zinit self-update
zinit update --all

echo ""
echo "=== conda (miniforge) ==="
conda update -n base -c conda-forge conda -y
conda update --all -y

echo ""
echo "=== nvm: update node LTS + npm ==="
nvm install 'lts/*' --reinstall-packages-from=current
nvm alias default 'lts/*'
npm install -g npm@latest

echo ""
echo "=== npm global packages ==="
npm update -g

echo ""
echo "=== gh extensions ==="
gh extension upgrade --all

echo ""
echo "=== vim-plug ==="
vim '+PlugUpgrade' '+PlugUpdate' '+qa'

echo ""
echo "=== snap ==="
snap refresh

echo ""
echo "=== flatpak ==="
flatpak update -y

echo ""
echo "=== Done! ==="
