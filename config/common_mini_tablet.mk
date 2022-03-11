# Inherit mini common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

$(call inherit-product, vendor/bliss/config/telephony.mk)
