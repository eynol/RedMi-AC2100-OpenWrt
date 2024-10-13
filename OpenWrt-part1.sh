#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: OpenWrt-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 自定义函数
addFeeds(){
  if [ $# == 2 ];then
    echo src-git $1 $2 >> feeds.conf.default
  fi
}

# Function to modify wireless configuration
modify_wireless_config() {
  # local wireless_config="/etc/config/wireless"
  local wireless_config="/root/test.txt"

  echo "Modifying wireless configuration..."

  # Enable wireless
  sed -i "s/option disabled '1'/option disabled '0'/g" $wireless_config
  
  # Set SSID and security
  sed -i "s/option ssid '.*'/option ssid 'Openwrt'/g" $wireless_config
  sed -i "s/option encryption '.*'/option encryption 'psk2'/g" $wireless_config
  # Set band (2g or 5g)
  # sed -i "s/option band '.*'/option band '$band'/" $wireless_config

  # Check if 'option key' exists in the configuration file
  if grep -q "option key" "$wireless_config"; then
      # If it exists, replace the existing key with 'pistarlink'
      sed -i "s/option key '.*'/option key '12345678'/g" "$wireless_config"
  else
      # If it doesn't exist, add the 'option key' line under the SSID configuration
      sed -i "/option ssid 'Openwrt'/a \    option key '12345678'" "$wireless_config"
  fi
  
  echo "Wireless configuration updated successfully!"
}
# execute
modify_wireless_config


# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 添加 feed 源
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# sed -i '$a src-git custom https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default
# addFeeds custom https://github.com/kiddin9/openwrt-packages.git

# 添加软件包源
# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon  #新的argon主题 (custom已附带)
# git clone --depth=1 https://github.com/llccd/openwrt-fullconenat.git package/openwrt-fullconenat #全锥形NAT (custom已附带)
# git clone --depth=1 https://github.com/peter-tank/luci-app-fullconenat package/luci-app-fullconenat #全锥形NAT LUCI界面 (custom已附带)
