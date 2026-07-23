#!/system/bin/sh
MODDIR=${0%/*}
LOGFILE="$MODDIR/cleaner.log"

log_debug() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [D] $1" | tee -a "$LOGFILE"
}

log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [I] $1" | tee -a "$LOGFILE"
}

log_warning() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [W] $1" | tee -a "$LOGFILE"
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [E] $1" | tee -a "$LOGFILE"
}

clean_firewall() {
    log_info "开始清理防火墙规则..."
    for proto in iptables ip6tables; do
        if ! command -v "$proto" > /dev/null 2>&1; then
            log_warning "未安装 $proto，跳过"
            continue
        fi

        if ! $proto -t filter -L -n >/dev/null 2>&1; then
            log_warning "filter 表不存在，跳过"
            continue
        fi

        chains=$($proto -t filter -L -n 2>/dev/null | grep '^Chain' | awk '{print $2}')
        for chain in $chains; do
            # 获取链中所有 DROP/REJECT 规则
            rules=$($proto -t filter -L "$chain" --line-numbers -n 2>/dev/null | grep -E 'DROP|REJECT')
            # 如果链中没有 DROP/REJECT 规则，跳过
            [ -z "$rules" ] && continue
            # 倒序删除规则，避免删除后规则编号变化
            nums=$(echo "$rules" | awk '{print $1}' | sort -rn)
            # 遍历规则编号，删除规则
            for num in $nums; do
                line=$(echo "$rules" | grep "^$num ")
                rule_content=$(echo "$line" | sed 's/^[0-9]\+ //')
                log_debug "发现规则：$proto filter/$chain: $rule_content"
                if $proto -t filter -D "$chain" "$num" 2>/dev/null; then
                    log_info "删除成功：$proto filter/$chain 规则 #$num"
                else
                    log_error "删除失败：$proto filter/$chain 规则 #$num"
                fi
            done
        done
    done
    log_info "清理完成"
}
