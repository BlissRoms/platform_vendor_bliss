# Inherit mobile full common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/common_mobile_full.mk)

# Inherit full tablet common BlissRoms stuff
$(call inherit-product, vendor/bliss/config/full_tablet.mk)

$(call inherit-product, vendor/bliss/config/telephony.mk)

