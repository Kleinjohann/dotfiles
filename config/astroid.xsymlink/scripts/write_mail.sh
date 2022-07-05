#!/usr/bin/env bash

export TERM='xterm-256color'

# base16-shell colour themes
BASE16_SHELL=$HOME/.config/base16-shell/
[ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

nvim -c 'set ft=mail' '+set fileencoding=utf-8' '+set ff=unix' '+set enc=utf-8' '+set fo+=w' "$@"

