#! /bin/bash

# Only if necessary
if command -v hie-wrapper >/dev/null; then
  echo "[+] hie-wrapper is already installed, skipping.";
else
  # Install pre-requisites
  sudo apt -qq update
  sudo apt -qq install -y libicu-dev libncurses-dev libgmp-dev

  # Clone repo and install
  ( cd /tmp;
    git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules;
    cd haskell-ide-engine;
    stack ./install.hs hie;
  )

  # Cleanup
  (cd /tmp && rm -rf ./haskell-ide-engine)
fi
