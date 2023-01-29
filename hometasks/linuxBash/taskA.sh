#!/bin/bash

display_help() {
    echo "Usage: $0 [--all] [--target]"
    echo "  --all          Display IP addresses and symbolic names of all hosts in the current subnet"
    echo "  --target       Display a list of open system TCP ports"
}

display_all() {
    # use arp-scan to scan the current subnet and display IP addresses and MAC
    arp-scan --localnet | awk '{print $1, $2}'
}

display_target() {
  # use nc to check for open ports on the specified IP address
  nmap -p- $1 | grep open
}

if [ $# -eq 0 ]; then
    display_help
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --all)
            display_all
            ;;
        --target)
            display_target $2
            ;;
        *)
            display_help
            exit 1
            ;;
    esac
    shift
done
