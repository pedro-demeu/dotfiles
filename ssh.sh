#!/usr/bin/env bash

email=$1

ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519

eval "$(ssh-agent -s)"

touch ~/.ssh/config
echo "Host *\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

ssh-add ~/.ssh/id_ed25519

echo "Chave gerada. Rode: cat ~/.ssh/id_ed25519.pub | clip.exe"
echo "Cole no GitHub em Settings > SSH and GPG keys"

