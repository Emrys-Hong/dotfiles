#!/bin/bash

function dirs() {
    # Get the IP address of the machine using ifconfig and awk
    ip=$(/usr/sbin/ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)

    output_file="/home/emrys/.dotfiles/scripts/gpu-stat/disk_usage_${ip}.txt"

    > "$output_file"

    echo "Last Update: $(date)" >> "$output_file"
    echo "" >> "$output_file"

    for dir in "$@"; do
        du -hxcs "$dir"/* 2>/dev/null | sort -hr >> "$output_file"
        echo "" >> "$output_file"
    done
}

# Usage: ./log_disk_usage.bash /data
dirs "$@"
