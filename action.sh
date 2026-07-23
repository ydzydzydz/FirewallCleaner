#!/system/bin/sh
MODDIR=${0%/*}

# shellcheck disable=SC3046
# shellcheck disable=SC1091
source "$MODDIR/common.sh"

clean_firewall
