echo "=========================================================="
# 1. 物理清洗：干掉不属于兆能 M2 的京东云亚瑟 LED 冲突残留
echo "=== 清理不属于 ZN-M2 的京东云 LED 插件 ==="
# 清除可能残存的 LED 插件和依赖
rm -rf package/emortal/luci-app-athena-led
rm -rf package/luci-app-athena-led


# 先将 dp1 的 "lan3" 改为临时占位符，再完成对调，避免冲突
ORIG_DIR=$(pwd)
DTSI_FILE="target/linux/qualcommax/dts/ipq6000-cmiot.dtsi"

# 检查文件是否存在
[ ! -f "$DTSI_FILE" ] && { echo "[ERROR] 找不到 $DTSI_FILE，当前目录: $(pwd)"; exit 1; }

echo "[INFO] 正在修改 $DTSI_FILE 中的 LAN 口 label..."

# 使用带时间戳的唯一占位符，避免与文件中已有字符串冲突
TMP="__LAN_TMP_$(date +%s)__"

# 三步对调：dp1 的 lan3 <-> dp4 的 lan1
sed -i '/&dp1 {/,/};/s/label = "lan3";/label = "'"$TMP"'";/' "$DTSI_FILE"
sed -i '/&dp4 {/,/};/s/label = "lan1";/label = "lan3";/' "$DTSI_FILE"
sed -i '/&dp1 {/,/};/s/label = "'"$TMP"'";/label = "lan1";/' "$DTSI_FILE"

# 验证修改结果
echo "[INFO] 修改后的 dp1 / dp4 label:"
grep -A1 "&dp1 {\|&dp4 {" "$DTSI_FILE" | grep "label"

# 安全返回原目录
cd "$ORIG_DIR"
echo "[INFO] LAN 口 label 对调完成"
