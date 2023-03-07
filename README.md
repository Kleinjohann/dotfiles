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
    - bash-git-prompt
    - ranger_devicons
- [tmux](https://github.com/tmux/tmux)
- [vim](https://github.com/vim/vim) (optionally replaced by neovim)

### Optional

- [ag](https://github.com/ggreer/the_silver_searcher)
- [flake8](https://flake8.pycqa.org/en/latest/index.html)
- [miniconda](https://docs.conda.io/en/latest/miniconda.html)
    - currently assumed to be located at `~/software/miniconda3`
    - this would have to be changed in:
        - `bashrc.symlink` (manual miniconda initialisation)
        - `vimrc.symlink` (only for neovim, environment for neovim python package)
- [neovim](https://github.com/neovim/neovim)
    - change vimtex compiler method if you don't use this
- [rg](https://github.com/BurntSushi/ripgrep)

### Full Desktop Environment (Optional, create symlinks with `-x` flag)

- all submodules of this repo
- [i3](https://github.com/i3/i3)
- Bindings and/or configs for these exist, but nothing else breaks without them:
    - all autostarts and workspace assignments in the i3 config
    - [astroid](https://github.com/astroidmail/astroid)
    - [autorandr](https://github.com/phillipberndt/autorandr)
    - [dunst](https://github.com/dunst-project/dunst)
    - [feh](https://feh.finalrewind.org)
    - [Flameshot](https://github.com/lupoDharkael/flameshot)
    - [contour](https://github.com/contour-terminal/contour)
    - [i3lock-fancy-dualmonitor](https://github.com/meskarune/i3lock-fancy/tree/dualmonitors)
    - [i3lock-color](https://github.com/Raymo111/i3lock-color)
        - change the screenlock binding if you don't use this
    - [mons](https://github.com/Ventto/mons)
    - [NetworkManager](https://wiki.gnome.org/Projects/NetworkManager)
        - disable polybar module if you don't use this
    - [nitrogen](https://github.com/l3ib/nitrogen)
    - [noisetorch](https://github.com/lawl/NoiseTorch)
    - [picom](https://github.com/yshui/picom)
    - [polybar](https://github.com/polybar/polybar)
    - [rofi](https://github.com/davatorium/rofi)
    - [rofi-calc](https://github.com/svenstaro/rofi-calc)
    - [ueberzug](https://github.com/seebye/ueberzug)
        - change the ranger preview method if you don't use this (only configured when passing `-x` flag, anyway)
    - [zathura](https://git.pwmt.org/pwmt/zathura)
        - change the view method for vimtex if you don't use this

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
User=user
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
