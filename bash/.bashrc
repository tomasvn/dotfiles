echo "  _____                   .__        __          "
echo "_/ ____\__________   ____ |__| _____/  |_ ___.__."
echo "\   __\/  ___/  _ \_/ ___\|  |/ __ \   __<   |  |"
echo " |  |  \___ (  <_> )  \___|  \  ___/|  |  \___  |"
echo " |__| /____  >____/ \___  >__|\___  >__|  / ____|"
echo "           \/           \/        \/      \/     "
echo "                                                 "

# Nix
alias ~='cd ~'
alias cmd='cd ~ && cat .bashrc'
alias c='clear'
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias bash-edit='be() { cd ~ && code .bashrc; }; be'

# Git
alias ga='git add -A'
alias gs='git status'
alias gsw='git switch -'
alias gcm='f() { git commit -m "$1"; }; f'
alias gu='git push'
alias guu='git push -u origin HEAD'
alias gp='git pull'
alias gf='git fetch --all'
alias gfp='git fetch --prune'
alias gl='git log --abbrev-commit'
alias gll='git log --all --decorate --oneline --graph'
alias gd='git diff ":!package-lock.json" ":!pnpm-lock.yaml"'
alias gds='git diff --staged ":!package-lock.json" ":!pnpm-lock.yaml"'
alias gc='f() { git checkout "$1"; }; f'
alias gb='git branch'
alias gbr='git branch -r'
alias gsl='git stash list'
alias gss='git status --short'
alias gsh='f() { git show "$1"; }; f'

# Project
alias web=''
alias pn='pnpm'
alias pns='pnpm start'
alias pnb='pnpm build'
alias np='npm'
alias nb='npm run build'
alias ns='npm run start'
