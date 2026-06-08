#!/usr/bin/env bash

set -e

echo "=== Setup inicial do ambiente ==="

# Perguntar nome e email do GitHub apenas se não estiver configurado
if ! git config --global user.name &>/dev/null; then
  read -p "Digite seu nome do GitHub: " github_name
  git config --global user.name "$github_name"
fi
if ! git config --global user.email &>/dev/null; then
  read -p "Digite seu email do GitHub: " github_email
  git config --global user.email "$github_email"
fi

echo "Utilizando nvim por padrão para WSL2 + Ubuntu"
core_editor="nvim"
git config --global core.editor "$core_editor"

echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "Instalando ferramentas essenciais..."
sudo apt install -y build-essential curl wget git htop python3 python3-pip direnv vlc ansible pipx docker.io docker-compose net-tools jq

echo "Instalando dependências para Neovim..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y make gcc ripgrep unzip git xclip neovim

echo "Instalando Node.js (via nvm)..."
if ! command -v nvm &> /dev/null; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm use --lts
fi

echo "Instalando Prettier e ESLint globalmente..."
if ! npm list -g prettier &>/dev/null; then
  npm install -g prettier eslint
fi

echo "Configurando pipx..."
pipx ensurepath

echo "Configurando direnv no bashrc..."
grep -qxF 'eval "$(direnv hook bash)"' ~/.bashrc || echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

echo "Configurando PATH para pipx..."
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo "Configurando variáveis de ambiente..."
grep -qxF 'export PROJECTS="$HOME/projects"' ~/.bashrc || echo 'export PROJECTS="$HOME/projects"' >> ~/.bashrc
grep -qxF 'export DOTFILES="$PROJECTS/dotfiles"' ~/.bashrc || echo 'export DOTFILES="$PROJECTS/dotfiles"' >> ~/.bashrc

echo "Carregando aliases e funções..."
grep -qxF 'source $DOTFILES/aliases.sh' ~/.bashrc || echo 'source $DOTFILES/aliases.sh' >> ~/.bashrc

echo "Aplicando symlink do bashrc..."
if [ -f "$DOTFILES/bashrc.syslink" ]; then
  grep -qF "$(cat $DOTFILES/bashrc.syslink)" ~/.bashrc || cat "$DOTFILES/bashrc.syslink" >> ~/.bashrc
fi

echo "Configurando aliases para nvim..."
grep -qxF 'alias n="nvim"' $DOTFILES/aliases.sh || echo 'alias n="nvim"' >> $DOTFILES/aliases.sh
grep -qxF 'alias vim="nvim"' $DOTFILES/aliases.sh || echo 'alias vim="nvim"' >> $DOTFILES/aliases.sh

echo "Configurando Docker..."
sudo usermod -aG docker $USER

echo "Configurando chave SSH..."
bash ./ssh.sh "$github_email"

echo "Configurando integração com LM Studio..."
sudo cp $DOTFILES/bin/chat /usr/local/bin/chat 
sudo chmod+x /usr/local/bin/chat

echo 'alias chatprompt="/usr/local/bin/chat"' >> $HOME/.bashrc
echo 'Prontinho, utilize chatprompt "Olá, mundo" e já poderá se comunicar com sua LLM no LM Studio'

echo "=== Setup concluído! ==="
echo "Execute: source ~/.bashrc"
echo "Mudanças aplicadas!"

