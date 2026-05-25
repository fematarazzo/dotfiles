# dotfiles

Configs I use day to day. Linux + Debian/Ubuntu mostly, but most of it
runs anywhere with a Unix shell.

## philosophy

- plain text, no framework-generated config
- comments explain the **why**, not the **what**
- plugin manager: none (vendored when needed)
- I update this when something bothers me for more than two weeks
- reinstalling from scratch should take less than an hour

## install

```sh
sudo apt install stow
git clone https://github.com/fematarazzo/dotfiles ~/.dotfiles
cd ~/.dotfiles && stow */
```

`stow` symlinks each folder into `~`. Tidy, no hand-rolled symlinks.

## what's in here

| folder      | what it is                                  |
|-------------|---------------------------------------------|
| `bash/`     | shell, aliases, readline                    |
| `nvim/`     | main editor (minimal init.lua)              |
| `vim/`      | fallback for servers without nvim           |
| `nano/`     | fallback for boxes without vim either       |
| `tmux/`     | multiplexer (prefix C-a, from screen)       |
| `git/`      | gitconfig + global gitignore                |
| `mpv/`      | video player                                |
| `ssh/`      | client config + hardening                   |
| `newsboat/` | terminal RSS reader                         |
| `borg/`     | excludes for daily backup                   |
| `ansible/`  | defaults                                    |
| `htop/`     | system monitor                              |
| `gnupg/`    | gpg.conf with modern algorithms             |
| `firefox/`  | user.js (hardening without breaking sites)  |
| `searxng/`  | self-hosted instance config                 |
| `curl/`     | retries + patient timeouts                  |
| `wget/`     | same idea                                   |
| `cinnamon/` | dconf dump for Cinnamon (HiDPI friendly)    |
| `scripts/`  | `~/bin` with personal utilities             |

## personal scripts (`scripts/bin/`)

- `pomodoro` — simple pomodoro with notify-send
- `journal` — opens/creates today's journal at `~/notes/journal/YYYY-MM-DD.md`
- `dotfiles-sync` — commit + push if anything changed
- `backup-daily` — borg local + Hetzner Storage Box
- `cinnamon-apply` — applies `cinnamon/dconf-settings.ini` (with auto backup)

## what's **not** in here

- no fancy shell prompt (a plain PS1 is enough)
- no shell frameworks (no oh-my-zsh, no starship)
- no nvim plugin managers (no Lazy, no Packer)
- no neon themes or animations
- no fancy dock (the xfce4-panel default is fine)

## notes

- I update this when something genuinely bothers me
- if any of this is useful to you, copy it. no credit needed.
- questions welcome — open an issue, I'll get to it.
