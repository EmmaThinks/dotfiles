#!/usr/bin/env bash

TARGET="192.168.1.71"

if ping -c 1 -W 2 "$TARGET" > /dev/null 2>&1; then
	echo "true"
else
	echo "false"
fi
