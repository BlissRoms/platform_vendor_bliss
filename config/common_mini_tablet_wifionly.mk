# Inherit mobile mini common Bliss stuff
$(call inherit-product, vendor/bliss/config/common_mobile_mini.mk)

# Inherit tablet common Bliss stuff
$(call inherit-product, vendor/bliss/config/tablet.mk)

$(call inherit-product, vendor/bliss/config/wifionly.mk)
