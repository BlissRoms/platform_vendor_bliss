# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=tokay_beta \
    persist.sys.pihooks_DEVICE?=tokay \
    persist.sys.pihooks_ID?=BP22.250124.009 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-02-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/tokay_beta/tokay:Baklava/BP22.250124.009/13034193:user/release-keys" \
    PihooksGmsModel="Pixel 9"

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml

# Keys
ifeq ($(BLISS_BUILD_TYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
