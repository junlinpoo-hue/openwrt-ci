echo "=========================================================="
# 1. 物理清洗：干掉不属于兆能 M2 的京东云亚瑟 LED 冲突残留
echo "=== 清理不属于 ZN-M2 的京东云 LED 插件 ==="
# 清除可能残存的 LED 插件和依赖
rm -rf package/emortal/luci-app-athena-led
rm -rf package/luci-app-athena-led


# （可选）根治物理端口映射：交换 DTS 中 lan1 和 lan4 的 label

DTSFILE="target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6000-zn-m2.dts"
if [ -f "$DTSFILE" ]; then
    echo "[Patch] Swapping lan1/lan4 label in DTS"
    sed -i 's/label = "lan1"/label = "lan1_temp"/g' "$DTSFILE"
    sed -i 's/label = "lan4"/label = "lan1"/g' "$DTSFILE"
    sed -i 's/label = "lan1_temp"/label = "lan4"/g' "$DTSFILE"
fi
