# Inherit mobile full common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

# Inherit tablet common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/tablet.mk)

$(call inherit-product, vendor/bliss/config/telephony.mk)

