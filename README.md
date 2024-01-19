# dotfiles

My dotfiles. I started from [Achilleas Koutsou](https://github.com/achilleas-k)'s configs for some of these, see e.g. his [vim configuration](https://github.com/achilleas-k/vimconfig).

## Screenshots

![](/screenshots/desktop_with_notification.png?raw=true)
![](/screenshots/tmux_with_vim_and_prompt.png?raw=true)

## Installation

Run `create_symlinks.sh` to create symlinks to the configuration files in this repo in your home directory. Optionally pass the `-x` flag to add configuration files for the full desktop environment, see below. You will be prompted to backup or delete existing configuration files, see code and comments in `create_symlinks.sh`.

## Requirements

### Necessary

- [autojump](https://github.com/wting/autojump)
- a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) for glyphs and Powerline characters
    - all configs in here use Fira Code and Fantasque Sans Mono
- [ranger](https://github.com/ranger/ranger)
- submodules:
    - base-16-shell
    - ranger_devicons
- [tmux](https://github.com/tmux/tmux)
- [vim](https://github.com/vim/vim) (optionally replaced by neovim)
- [zsh](https://www.zsh.org)

### Optional

- [ag](https://github.com/ggreer/the_silver_searcher)
- [flake8](https://flake8.pycqa.org/en/latest/index.html)
- [keychain](https://www.funtoo.org/Funtoo:Keychain)
- [neovim](https://github.com/neovim/neovim)
    - change vimtex compiler method if you don't use this
- [rg](https://github.com/BurntSushi/ripgrep)

### Full Desktop Environment (Optional, create symlinks with `-x` flag)

- all submodules of this repo
- [sway](https://github.com/swaywm/sway)
- Bindings and/or configs for these exist, but nothing else breaks without them:
    - all autostarts and workspace assignments in the i3 config
    - [astroid](https://github.com/astroidmail/astroid)
    - [dunst](https://github.com/dunst-project/dunst)
    - [contour](https://github.com/contour-terminal/contour)
    - [grim](https://github.com/emersion/grim) and [slurp](https://github.com/emersion/slurp)
    - [NetworkManager](https://wiki.gnome.org/Projects/NetworkManager)
        - disable polybar module if you don't use this
    - [noisetorch](https://github.com/lawl/NoiseTorch)
    - [rofi with wayland support](https://github.com/lbonn/rofi#wayland-support)
    - [rofi-calc](https://github.com/svenstaro/rofi-calc)
    - [waybar](https://github.com/Alexays/Waybar)
    - [waylock](https://codeberg.org/ifreund/waylock)
    - [wl-clipboard](https://github.com/bugaevc/wl-clipboard)
    - [zathura](https://git.pwmt.org/pwmt/zathura)
        - change the view method for vimtex if you don't use this

## Installation Tips

- [install tmux locally without root access](https://gist.github.com/smsharma/0003b61a571cab63ad80)

## Services / Hooks

automatically lock screen on suspend/sleep/hibernate
```
[Unit]
Description=Lock screen before suspend
Before=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=user
Type=simple
Environment=DISPLAY=:0
ExecStart=/bin/sh -c "~/.config/sway/scripts/lock_screen.sh"

[Install]
WantedBy=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

ensure the screen is locked before suspend/sleep/hibernate
```
[Unit]
Description=Wait for Screen Lock
Before=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=user
Type=oneshot
Environment=DISPLAY=:0
ExecStart=/bin/sleep 3

[Install]
WantedBy=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

automatically turn wifi off/on when connecting to/disconnecting from a wired network
```
#!/bin/bash
wired_interfaces="en.*|eth.*"
if [[ "$1" =~ $wired_interfaces ]]; then
    case "$2" in
        up)
            nmcli radio wifi off
            ;;
        down)
            nmcli radio wifi on
            ;;
    esac
fi
```
