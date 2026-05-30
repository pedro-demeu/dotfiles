#!/usr/bin/env bash

set -e

echo "=== Setup inicial do ambiente ==="

# Perguntar nome e email do GitHub
read -p "Digite seu nome do GitHub: " github_name
read -p "Digite seu email do GitHub: " github_email

echo "Utilizando nvim por padrão para WSL2 + Ubuntu"
core_editor="nvim"

echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "Instalando ferramentas essenciais..."
sudo apt install -y build-essential curl wget git neovim htop python3 python3-pip python3-pip direnv vlc

echo "Instalando Node.js (via nvm)..."
if ! command -v nvm &> /dev/null; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
nvm install --lts
nvm use --lts

echo "Configurando Git..."
git config --global user.name "$github_name"
git config --global user.email "$github_email"
git config --global core.editor "$core_editor"

echo "Instalando Prettier globalmente..."
npm install -g prettier eslint

echo "Instalando pipx..."
python3 -m pip install --user pipx
python3 -m pipx ensurepath

echo "Configurando direnv no bashrc..."
if ! grep -q 'direnv hook bash' ~/.bashrc; then
  echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
fi


echo "Configurando PATH para pipx..."
if ! grep -q '.local/bin' ~/.bashrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

echo "Setup concluído!"
echo "Execute: source ~/.bashrc"
echo "Mudanças aplicadas!"
