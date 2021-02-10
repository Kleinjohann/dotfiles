# dotfiles

## Non-Obvious Requirements

- [ag](https://github.com/ggreer/the_silver_searcher) (also available via apt)
- [autojump](https://github.com/wting/autojump) (also available via apt)
- [i3lock-color](https://github.com/Raymo111/i3lock-color)
- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [Flameshot](https://github.com/lupoDharkael/flameshot) (also available via apt)
- [mons](https://github.com/Ventto/mons)
- [noisetorch](https://github.com/lawl/NoiseTorch)
- [rg](https://github.com/BurntSushi/ripgrep) (also available via apt)

## Installation Tips

- [compile polybar](https://gist.github.com/kuznero/f4e983c708cd2bdcadc97be695baacf8)
- [install tmux locally without root access](https://gist.github.com/smsharma/0003b61a571cab63ad80)

## Services

automatically lock screen on suspend/sleep/hibernate
```
[Unit]
Description=Lock screen before suspend
Before=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=kleinjohann
Type=simple
Environment=DISPLAY=:0
ExecStart=/home/kleinjohann/.config/i3/scripts/lock_screen.sh

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
