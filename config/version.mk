# Bliss ROM Version Configuration
#
# External variables (set by build system or manually):
#   BLISS_BUILD        - Device codename
#   BLISS_BUILDTYPE    - Build type (OFFICIAL, COMMUNITY, etc.) - defaults to UNOFFICIAL
#   BLISS_BUILD_VARIANT - Build variant (vanilla, gapps, etc.) - defaults to vanilla

BLISS_VERSION_MAJOR := 19
BLISS_VERSION_MINOR := 3
BLISS_CODENAME := Waterlily
BLISS_PROJECT := BlissRoms

# Bliss Android Version
BLISS_VERSION_STATIC := 16.0

# Set Bliss Build Variant
BLISS_BUILD_VARIANT ?= vanilla

# Set to Unofficial if no buildtype is set
BLISS_BUILDTYPE ?= UNOFFICIAL

TARGET_PRODUCT_SHORT := $(subst bliss_,,$(BLISS_BUILDTYPE))

VERSION := $(BLISS_VERSION_MAJOR).$(BLISS_VERSION_MINOR)

# Set BLISS build zip name
BLISS_BUILD_ZIP := Bliss-v$(VERSION)-$(BLISS_BUILD)-$(BLISS_BUILDTYPE)-$(BLISS_BUILD_VARIANT)-$(shell date +%Y%m%d)

BLISS_DEVICE := $(BLISS_BUILD)
BLISS_VERSION := $(VERSION)
BLISS_DISPLAY_BUILDTYPE := $(BLISS_BUILDTYPE)
BLISS_FINGERPRINT := Bliss/$(VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d)
BLISS_BUILD_TIMESTAMP := $(shell date +%Y%m%d)
BLISS_BUILD_VERSION := $(BLISS_BUILD_ZIP)

# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Bliss version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bliss.project=$(BLISS_PROJECT) \
    ro.bliss.codename=$(BLISS_CODENAME) \
    ro.bliss.device=$(BLISS_DEVICE) \
    ro.bliss.version=$(BLISS_VERSION) \
    ro.bliss.build.status=$(BLISS_BUILDTYPE) \
    ro.bliss.fingerprint=$(BLISS_FINGERPRINT) \
    ro.bliss.static.version=$(BLISS_VERSION_STATIC) \
    ro.bliss.build.variant=$(BLISS_BUILD_VARIANT) \
    ro.bliss.build.timestamp=$(BLISS_BUILD_TIMESTAMP) \
    ro.bliss.build=$(BLISS_BUILD_ZIP)
