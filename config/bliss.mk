# Bliss Extras
$(call inherit-product-if-exists, vendor/extras/extras.mk)

# Bliss Packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    OmniJaws

# Keys
ifeq ($(BLISS_BUILD_TYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
