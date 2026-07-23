#!/system/bin/sh

ui_print " "
ui_print "=============================================="
ui_print "      防火墙清理器 - 风险提示"
ui_print "=============================================="
ui_print " "
ui_print "本模块功能："
ui_print "  - 开机自动清除所有 DROP/REJECT 规则"
ui_print "  - 支持手动触发清理（终端执行 action.sh）"
ui_print " "
ui_print "清理范围："
ui_print "  - 自定义链"
ui_print "  - INPUT/OUTPUT/FORWARD 链"
ui_print "  - IPv4 (iptables) 和 IPv6 (ip6tables)"
ui_print " "
ui_print "=============================================="
ui_print "      免责声明 / DISCLAIMER"
ui_print "=============================================="
ui_print " "
ui_print "【重要】安装或使用本模块即表示您同意"
ui_print "以下全部条款："
ui_print " "
ui_print "1. 功能说明"
ui_print "  本模块是一个防火墙规则清理工具，用于"
ui_print "  清除设备上已存在的 DROP/REJECT 规则。"
ui_print "  规则可能来源于：其他模块、APP、系统"
ui_print "  预置或用户手动配置。"
ui_print " "
ui_print "2. 知情同意"
ui_print "  用户已知悉并理解："
ui_print "  - 本模块会清除所有 DROP/REJECT 规则"
ui_print "  - 这可能导致原防火墙策略失效"
ui_print "  - 用户应确保清除规则符合自身需求"
ui_print " "
ui_print "3. 合法使用"
ui_print "  用户承诺："
ui_print "  - 仅将本模块用于合法用途"
ui_print "  - 遵守当地法律法规"
ui_print "  - 不使用本模块进行任何非法活动"
ui_print " "
ui_print "4. 风险承担"
ui_print "  本模块按\"现状\"提供，作者不对因使用"
ui_print "  本模块导致的任何直接或间接损失负责。"
ui_print "  用户应在使用前自行评估风险。"
ui_print " "

while true; do
    ui_print " "
    ui_print "=============================================="
    ui_print "  [音量上键]   确认并安装（表示同意上述条款）"
    ui_print "  [音量下键]   取消并退出"
    ui_print "=============================================="
    ui_print " "

    choose_volume_key() {
        timeout_seconds=10
        ui_print "请在 $timeout_seconds 秒内输入按键，确认安装或取消安装"
        ui_print "若超时未输入则使用默认选项（取消安装）"
        line=$(timeout $timeout_seconds getevent -ql | awk '/KEY_VOLUME/ {print; exit}')
        if [ -z "$line" ]; then
            ui_print "未检测到按键输入，取消安装..."
            return 1
        fi
        if echo "$line" | grep -q "KEY_VOLUMEUP"; then
            return 0
        else
            return 1
        fi
    }

    if choose_volume_key; then
        ui_print "正在安装防火墙清理器..."
        break
    else
        ui_print "安装已取消"
        exit 1
    fi
done
