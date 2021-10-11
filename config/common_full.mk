# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
