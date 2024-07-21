# Inherit mobile full common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

# Inherit full tablet common Bliss stuff
$(call inherit-product, vendor/bliss/config/full_tablet.mk)

$(call inherit-product, vendor/bliss/config/wifionly.mk)
