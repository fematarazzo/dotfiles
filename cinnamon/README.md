# cinnamon

Cinnamon config tuned for HiDPI. Sized for a 14" WQHD/4K laptop screen.

## philosophy

- bottom panel, "Windows 7" style
- no animations, no neon
- legible fonts without being huge
- pragmatic keyboard shortcuts
- nothing on the desktop (or only Home + Trash)

## apply

```sh
# load everything in one go
dconf load / < dconf-settings.ini

# or via the wrapper script
~/bin/cinnamon-apply
```

Cinnamon needs a logout/login for everything to pick up.

## what each section does

| section                               | what                                          |
|---------------------------------------|-----------------------------------------------|
| `org/cinnamon`                        | panel, applets, global effects                |
| `org/cinnamon/theme`                  | shell theme (window decoration, panel)        |
| `org/cinnamon/desktop/interface`      | GTK theme, icons, fonts                       |
| `org/cinnamon/desktop/wm/preferences` | titlebar and focus                            |
| `org/cinnamon/muffin`                 | compositor (animations, fractional scaling)   |
| `org/cinnamon/settings-daemon/...`    | power, keyboard                               |
| `org/cinnamon/desktop/keybindings`    | keyboard shortcuts                            |
| `org/nemo`                            | file manager                                  |
| `org/gnome/desktop/interface`         | text scaling (HiDPI fractional)               |

## theme choices

- **GTK**: Mint-Y (Mint default, muted, consistent)
- **Icons**: Papirus
- **Cursor**: DMZ-White (or Bibata-Modern-Classic if preferred)
- **Cinnamon shell**: Mint-Y

Why: everything ships in Debian/Mint repos. Updates with the system, no PPAs.

## HiDPI specifics

Three layers stacked:

1. **Scaling factor**: 2 (integer scale for the Cinnamon framework).
2. **Text scaling factor**: 0.875 (compensates the 2x, lands around 1.75x).
3. **Window scaling factor**: inherits from scaling factor.

Combined, gives effective ~150-175% which works well on 14" WQHD/4K.

For "true" fractional scaling (without the text-scaling trick), you'd need
Wayland — as of 2026, Cinnamon Wayland is still experimental. For now,
X11 + the trick is the stable option.
