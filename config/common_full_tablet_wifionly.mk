# Inherit mobile full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

# Inherit tablet common Bliss stuff
$(call inherit-product, vendor/bliss/config/tablet.mk)

$(call inherit-product, vendor/bliss/config/wifionly.mk)
