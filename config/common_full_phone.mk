# Inherit full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include bliss LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/bliss/config/telephony.mk)
