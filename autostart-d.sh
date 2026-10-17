#!/usr/bin/bash
path="$HOME/.config/autostart.d"

sleep 5 && \
for i in $(dir "$path"); do
  gio launch "$path/$i"
done
