# Inherit full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/dictionaries

$(call inherit-product, vendor/bliss/config/telephony.mk)
