# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

# Inherit Bliss atv device tree
$(call inherit-product, device/bliss/atv/bliss_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Bliss packages
PRODUCT_PACKAGES += \
    LineageCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/bliss/overlay/tv
