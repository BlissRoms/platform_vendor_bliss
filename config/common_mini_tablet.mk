$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mini common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/bliss/config/telephony.mk)
