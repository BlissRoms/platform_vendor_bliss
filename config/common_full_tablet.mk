$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit mobile full common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

$(call inherit-product, vendor/bliss/config/telephony.mk)
