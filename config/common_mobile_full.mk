# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder

# Include Bliss LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/bliss/overlay/dictionaries
