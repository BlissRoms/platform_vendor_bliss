# Bliss Extras
$(call inherit-product-if-exists, vendor/extras/extras.mk)

# Bliss Packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    Neuron \
    OmniJaws

# Enable Material Design 3 Expressive
PRODUCT_PRODUCT_PROPERTIES += is_expressive_design_enabled=true

# Keys
ifeq ($(BLISS_BUILD_TYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
