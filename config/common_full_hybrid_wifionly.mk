# Inherit common stuff
$(call inherit-product, vendor/bliss/config/common.mk)
$(call inherit-product, vendor/bliss/config/common_full.mk)

PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/tablet

# BT config
PRODUCT_COPY_FILES += \
    system/bluetooth/data/main.nonsmartphone.conf:system/etc/bluetooth/main.conf
