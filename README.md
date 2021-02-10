# dotfiles

Disclaimer: use at your own risk, no full installation instructions as of now, not everything is nicely organised and documented

## Installation

<mark>Run `create_symlinks.sh` to create symlinks to the configuration files in this repo in your home directory. Optionally pass the `-x` flag to add configuration files for the full desktop environment, see below. You will be propted to backup or delete existing configuration files, see code and comments in `create_symlinks.sh`.</mark>

## Requirements

### Necessary

- [autojump](https://github.com/wting/autojump)
- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [ranger](https://github.com/ranger/ranger)
- submodules:
    - base-16-shell
    - bash-git-prompt
    - ranger_devicons
- [tmux](https://github.com/tmux/tmux)
- [vim](https://github.com/vim/vim) (optionally replaced by neovim)

### Optional

- [ag](https://github.com/ggreer/the_silver_searcher)
- [flake8](https://flake8.pycqa.org/en/latest/index.html)
- [miniconda](https://docs.conda.io/en/latest/miniconda.html)
- [neovim](https://github.com/neovim/neovim)
- [rg](https://github.com/BurntSushi/ripgrep)

### Full Desktop Environment (Optional, create symlinks with `-x` flag)

- all submodules of this repo
- [dunst](https://github.com/dunst-project/dunst)
- [feh](https://feh.finalrewind.org)
- [Flameshot](https://github.com/lupoDharkael/flameshot)
- [i3](https://github.com/i3/i3)
- [i3lock-color](https://github.com/Raymo111/i3lock-color)
- [mons](https://github.com/Ventto/mons)
- [noisetorch](https://github.com/lawl/NoiseTorch)
- [picom](https://github.com/yshui/picom)
- [polybar](https://github.com/polybar/polybar)
- [zathura](https://git.pwmt.org/pwmt/zathura)

## Installation Tips

- [compile polybar](https://gist.github.com/kuznero/f4e983c708cd2bdcadc97be695baacf8)
- [install tmux locally without root access](https://gist.github.com/smsharma/0003b61a571cab63ad80)

## Services / Hooks

automatically lock screen on suspend/sleep/hibernate
```
[Unit]
Description=Lock screen before suspend
Before=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=kleinjohann
Type=simple
Environment=DISPLAY=:0
ExecStart=/bin/sh -c "~/.config/i3/scripts/lock_screen.sh"

[Install]
WantedBy=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

ensure the screen is locked before suspend/sleep/hibernate
```
[Unit]
Description=Wait for Screen Lock
Before=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=kleinjohann
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
