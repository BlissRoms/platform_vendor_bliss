# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
