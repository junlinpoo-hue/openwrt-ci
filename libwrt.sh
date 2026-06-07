echo "=========================================================="
# 1. 物理清洗：干掉不属于兆能 M2 的京东云亚瑟 LED 冲突残留
echo "=== 清理不属于 ZN-M2 的京东云 LED 插件 ==="
# 清除可能残存的 LED 插件和依赖
rm -rf package/emortal/luci-app-athena-led
rm -rf package/luci-app-athena-led


# 先将 dp1 的 "lan3" 改为临时占位符，再完成对调，避免冲突
sed -i '/&dp1 {/,/};/s/label = "lan3";/label = "lan_tmp";/g' ipq6000-cmiot.dtsi
sed -i '/&dp4 {/,/};/s/label = "lan1";/label = "lan3";/g' ipq6000-cmiot.dtsi
sed -i '/&dp1 {/,/};/s/label = "lan_tmp";/label = "lan1";/g' ipq6000-cmiot.dtsi

# 返回源码根目录继续编译
cd ../../../../
