$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

$(call inherit-product, vendor/bliss/config/wifionly.mk)
