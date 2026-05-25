# ~/.bashrc
# I keep this short. When it crosses 100 lines, I refactor.

# bail out if not interactive
case $- in
    *i*) ;;
      *) return;;
esac

# ── history ────────────────────────────────────────────
# never want to lose command history.
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s cmdhist

# save each command immediately (survives a terminal crash)
PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# ── shell behavior ─────────────────────────────────────
shopt -s checkwinsize
shopt -s globstar
shopt -s nocaseglob
shopt -s autocd

# ── prompt ─────────────────────────────────────────────
# user@host:dir (branch)$ — works in any terminal
parse_git_branch() {
    git branch 2>/dev/null | sed -n 's/^\* \(.*\)/ (\1)/p'
}
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]$(parse_git_branch)\[\e[0m\]\$ '

# ── path ───────────────────────────────────────────────
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"

# ── editor ─────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R --use-color -j.5'

# python REPL startup
export PYTHONSTARTUP="$HOME/.config/python/pythonrc.py"

# ── locale ─────────────────────────────────────────────
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ── colors ─────────────────────────────────────────────
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# ── aliases ────────────────────────────────────────────
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ── completion ─────────────────────────────────────────
if ! shopt -oq posix; then
    [ -f /usr/share/bash-completion/bash_completion ] && \
        . /usr/share/bash-completion/bash_completion
fi

# ── direnv ─────────────────────────────────────────────
command -v direnv >/dev/null && eval "$(direnv hook bash)"

# ── fzf (Ctrl-R history search) ────────────────────────
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && \
    . /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && \
    . /usr/share/doc/fzf/examples/completion.bash
