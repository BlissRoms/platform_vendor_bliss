$(call inherit-product, $(SRC_TARGET_DIR)/product/large_screen_foldable_common.mk)

# Inherit mobile full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/bliss/config/telephony.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/foldable_book
