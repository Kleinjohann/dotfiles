#!/bin/bash

# see https://github.com/lawl/NoiseTorch/issues/24
# pulseaudio docs: https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-echo-cancel

# Stop any existing Noisetorch instance
noisetorch -u

# make sure the echo cancel module is unloaded
pactl unload-module module-echo-cancel

# load the echo cancel module
pactl load-module module-echo-cancel use_master_format=1 aec_method=webrtc aec_args="analog_gain_control=0\ digital_gain_control=1\ noise_suppression=1" source_name=echoCancel_source sink_name=echoCancel_sink

# set your output device to the echo cancelled sink
pacmd set-default-sink echoCancel_sink

# set your input device to the echo cancelled source
pacmd set-default-source echoCancel_source

# start NoiseTorch with the echo cancelled source (default)
noisetorch -i

