echo "=========================================================="
# 1. 物理清洗：干掉不属于兆能 M2 的京东云亚瑟 LED 冲突残留
echo "=== 清理不属于 ZN-M2 的京东云 LED 插件 ==="
# 清除可能残存的 LED 插件和依赖
rm -rf package/emortal/luci-app-athena-led
rm -rf package/luci-app-athena-led


