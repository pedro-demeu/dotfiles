#!/usr/bin/env bash

set -e

echo "=== Setup inicial do ambiente ==="

# Perguntar nome e email do GitHub
read -p "Digite seu nome do GitHub: " github_name
read -p "Digite seu email do GitHub: " github_email

# Perguntar editor
echo "Escolha seu editor padrão para o Git:"
echo "1) nvim (default)"
echo "2) nano"
read -p "Selecione [1-2]: " editor_choice

case $editor_choice in
  2) core_editor="nano" ;;
  *) core_editor="nvim" ;;
esac

echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "Instalando ferramentas essenciais..."
sudo apt install -y build-essential curl wget git neovim htop python3 python3-pip

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
npm install -g prettier

echo "Setup concluído!"

