alias pubkey="cat ~/.ssh/id_ed25519.pub | clip.exe"
extract () {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.gz)   tar -zxvf "$1" ;;
            *.tar.bz2)  tar -jxvf "$1" ;;
            *.tar)      tar -xvf "$1" ;;
            *.gz)       gunzip "$1" ;;
            *.bz2)      bunzip2 "$1" ;;
            *.zip|*.ZIP) unzip "$1" ;;
            *)          echo "'$1' não pode ser extraído com extract()" ;;
        esac
    else
        echo "'$1' não é um arquivo válido"
    fi
}
alias ~="cd ~"
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

# Servidor HTTP rápido
server() {
  local port="${1:-8011}"
  xdg-open "http://localhost:${port}/" &
  statikk --port "$port" .
}
# VIM Aliases
alias n="nvim"
alias vim="nvim"

# My Favorite Aliases
alias p="cd $PROJECTS"

# Git Aliases
alias gs="git status"
alias gc="git commit -m"
alias log="git log --oneline --graph --decorate --color --date=short --pretty=format:'%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %C(auto)%d%Creset %s'"
alias gp="git push"
alias fetch="git fetch"
alias sync="git fetch && git pull && git push"

# Diff rápido
alias diff="git diff"
alias difff="git diff --stat"
alias diffc="git diff --cached"
alias diffn="nvim -d"

