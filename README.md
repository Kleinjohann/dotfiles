# dotfiles

## Non-Obvious Requirements

- [autojump](https://github.com/wting/autojump) (also available via apt)
- [i3lock-fancy](https://github.com/meskarune/i3lock-fancy/tree/dualmonitors) (dualmonitors branch for multi-monitor support)
- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts)
- [Flameshot](https://github.com/lupoDharkael/flameshot) (also available via apt)

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
Type=forking
Environment=DISPLAY=:0
ExecStart=/home/kleinjohann/.config/i3/scripts/lock_screen-service.sh

[Install]
WantedBy=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

reenable notifications when waking up from suspend/sleep/hibernate
```
[Unit]
Description=Reenable notifications after suspend
After=sleep.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
User=kleinjohann
Type=oneshot
Environment=DISPLAY=:0
ExecStart=/home/kleinjohann/.config/i3/scripts/notifications.sh on

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
