LOCAL_PATH := $(call my-dir)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

# Common
include vendor/celestial/config/common.mk

# Version
include vendor/celestial/config/version.mk

# overrides
include vendor/celestial/config/overrides.mk

# Clocks
$(call inherit-product-if-exists, vendor/SystemUIClocks/product.mk)

# OTA
include vendor/celestial/config/ota.mk

# Themes
$(call inherit-product, vendor/celestial/config/themes.mk)

# Plugins
#include packages/apps/PotatoPlugins/plugins.mk
