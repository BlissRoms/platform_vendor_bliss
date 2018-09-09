PRODUCT_COPY_FILES += \
    vendor/bliss/utils/emulator/fstab.ranchu:vendor/etc/fstab.ranchu \
    vendor/bliss/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

$(call inherit-product, build/target/product/sdk_x86.mk)

$(call inherit-product, vendor/bliss/config/common.mk)

$(call inherit-product, vendor/bliss/utils/emulator/common.mk)

# Override product naming for Omni
PRODUCT_NAME := bliss_emulator

DEVICE_PACKAGE_OVERLAYS += vendor/bliss/utils/emulator/overlay

ALLOW_MISSING_DEPENDENCIES := true 
