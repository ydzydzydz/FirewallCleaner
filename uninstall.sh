#!/system/bin/sh
MODDIR=${0%/*}

rm -f "$MODDIR/cleaner.log"

ui_print " "
ui_print "=============================================="
ui_print "防火墙清理器已卸载"
ui_print "请重启设备以恢复防火墙规则"
ui_print "=============================================="
