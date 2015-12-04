# Inherit common stuff
$(call inherit-product, vendor/bliss/config/common.mk)
$(call inherit-product, vendor/bliss/config/common_full.mk)
$(call inherit-product, vendor/bliss/config/common_apn.mk)

# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk
