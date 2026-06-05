echo "=========================================================="
# 1. 物理清洗：干掉不属于兆能 M2 的京东云亚瑟 LED 冲突残留
echo "=== 清理不属于 ZN-M2 的京东云 LED 插件 ==="
# 清除可能残存的 LED 插件和依赖
rm -rf package/emortal/luci-app-athena-led
rm -rf package/luci-app-athena-led
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns

# ==========================================================
# 2. 核心注入：强行克隆适配 Linux 6.12 架构（.apk 时代）的 SmartDNS 源码
echo "=== 强行向核心 package 树注入现代版 SmartDNS 源码 ==="
# 克隆专门适配了新内核与大分区的 SmartDNS 开源源码
git clone --depth 1 https://github.com package/smartdns
git clone --depth 1 https://github.com package/luci-app-smartdns


# ==========================================================
# 3. 终极防抹除：尾部追加固化，扭转系统的反向降写，强制锁死主路由核心组件
echo "=== 强制固化写入全中文、拨号主路由、内核剔除配置 ==="
cat <<EOF >> .config

# ---------- 核心补丁：补齐全局中文骨架，告别全英文 ----------
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y

# ---------- 核心补丁：强制锁死 SmartDNS 核心、网页壳与全中文前端 ----------
CONFIG_PACKAGE_smartdns=y
CONFIG_PACKAGE_luci-app-smartdns=y
CONFIG_PACKAGE_luci-i18n-smartdns-zh-cn=y
EOF

echo "=========================================================="
echo "=== 兆能 M2 有线主路由 libwrt.sh 终极改造全部完成！ ==="
echo "=========================================================="
