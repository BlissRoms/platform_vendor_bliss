$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile mini common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_mini.mk)

$(call inherit-product, vendor/bliss/config/wifionly.mk)
