# Bliss Extras
$(call inherit-product-if-exists, vendor/extras/extras.mk)

# Official build verification
BLISS_BUILDTYPE ?= UNOFFICIAL
BLISS_OFFICIAL_KEY := vendor/bliss-priv/keys/releasekey.pk8
BLISS_OFFICIAL_KEY_SHA256 := 9948df9b643ed6baf85679f9c31a5d9cce0ea84ed5fe70efefb044afd1179d60

ifeq ($(BLISS_BUILDTYPE),OFFICIAL)
  BLISS_KEY_SHA256 := $(shell openssl pkey -inform DER -in $(BLISS_OFFICIAL_KEY) -pubout -outform DER 2>/dev/null | sha256sum | cut -d' ' -f1)
  ifneq ($(BLISS_KEY_SHA256),$(BLISS_OFFICIAL_KEY_SHA256))
    $(warning BlissRoms release key not found or does not match. Building as UNOFFICIAL.)
    override BLISS_BUILDTYPE := UNOFFICIAL
  endif
endif

# Bliss Packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    LMOFreeform \
    LMOFreeformSidebar \
    OmniJaws

# Keys
ifeq ($(BLISS_BUILDTYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
