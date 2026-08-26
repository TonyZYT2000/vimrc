#!/usr/bin/env zsh
source ~/.zshrc
set -e

has() {
  (( $+commands[$1] || $+functions[$1] ))
}

if has uv; then
  echo "=== uv ==="
  uv self update
  uv tool upgrade --all
  echo ""
fi

if has rustup; then
  echo "=== rustup ==="
  rustup update
  echo ""
fi

if has zinit; then
  echo "=== zinit self-update + plugin update ==="
  zinit self-update
  zinit update --all
  echo ""
fi

if has conda; then
  echo "=== conda (miniforge) ==="
  conda update -n base -c conda-forge conda -y
  conda update --all -y
  echo ""
fi

if has nvm; then
  echo "=== nvm: update node LTS + npm ==="
  if [[ "$(nvm current)" != "$(nvm version --lts)" ]]; then
    nvm install --lts --latest-npm --reinstall-packages-from=current
  else
    nvm install --lts --latest-npm
  fi
  nvm alias default "$(nvm version --lts)"
  echo ""
fi

if has npm; then
  echo "=== npm global packages ==="
  npm update -g
  echo ""
fi

if has gh; then
  echo "=== gh extensions ==="
  gh extension upgrade --all
  echo ""
fi

if has herdr; then
  echo "=== herdr ==="
  herdr update
  echo ""
fi

if has vim; then
  echo "=== vim-plug ==="
  vim '+PlugUpgrade' '+PlugUpdate' '+qa'
  echo ""
fi

if has snap; then
  echo "=== snap ==="
  snap refresh
  echo ""
fi

if has flatpak; then
  echo "=== flatpak ==="
  flatpak update -y
  echo ""
fi

echo "=== Done! ==="
