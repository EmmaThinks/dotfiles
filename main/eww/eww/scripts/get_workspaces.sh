#!/usr/bin/env bash

hyprctl activeworkspace -j | jq -r '.id'

socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
  case "$line" in
    workspacev2*)
      echo "${line#*>>}" | cut -d',' -f1
      ;;
  esac
done
