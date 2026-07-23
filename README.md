# Firewall Cleaner

一个 KernelSU/Magisk 模块，用于清理所有 DROP 和 REJECT 防火墙规则。

## 功能

- 清除 `iptables` 和 `ip6tables` 中的 DROP/REJECT 规则
- 支持清理自定义链和内置链 (INPUT/OUTPUT/FORWARD)
- 生成清理日志：`/data/adb/modules/FirewallCleaner/cleaner.log`

## 警告

**安装前请务必阅读以下内容：**

本模块会清除设备上**所有** DROP 和 REJECT 规则，包括：
- 其他 KernelSU/Magisk 模块设置的规则
- 防火墙 APP 设置的规则
- 系统预置或用户手动配置的规则

清除后您的设备将失去这些规则的保护。请确认您确实需要清除这些规则。

## 安装

1. 下载最新版本的 `FirewallCleaner-v<x.x.x>.zip`
2. 安装下载的 zip 文件，音量上键确认安装，音量下键取消安装
3. 重启设备
