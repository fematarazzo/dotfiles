# aliases — I add one when I've typed the same command three times

# ── navigation ─────────────────────────────────────────
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── safety ─────────────────────────────────────────────
# I've paid for not having these. Won't pay again.
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ── git ────────────────────────────────────────────────
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git pull --ff-only'
alias gco='git checkout'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'

# ── system ─────────────────────────────────────────────
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='ss -tulanp'
alias myip='curl -s ifconfig.me && echo'

# ── apt ────────────────────────────────────────────────
alias apti='sudo apt install'
alias apts='apt search'
alias aptu='sudo apt update && sudo apt full-upgrade'
alias aptr='sudo apt remove'

# ── work ───────────────────────────────────────────────
alias k=kubectl
alias tf=tofu
alias ans=ansible
alias play='ansible-playbook'

# ── personal ───────────────────────────────────────────
alias notes='cd ~/notes && nvim'
alias journal='nvim ~/notes/journal/$(date +%Y-%m-%d).md'
alias pomo='~/bin/pomodoro 25'

# ── misc ───────────────────────────────────────────────
alias serve='python3 -m http.server'
weather() { curl -s "wttr.in/${1:-}"; }
