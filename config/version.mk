BLISS_VERSION_MAJOR := 18
BLISS_VERSION_MINOR := 7
BLISS_CODENAME = Voyager

# Bliss Android Version
BLISS_VERSION_STATIC = 15.0

# Set Bliss Build Variant
BLISS_BUILD_VARIANT ?= vanilla

TARGET_PRODUCT_SHORT := $(subst bliss_,,$(BLISS_BUILDTYPE))

VERSION := $(BLISS_VERSION_MAJOR).$(BLISS_VERSION_MINOR)

# Set to Unofficial if no buildtype is set (Build Types should be only set by Bliss Devs!)
ifdef BLISS_BUILDTYPE
else
    BLISS_BUILDTYPE ?= UNOFFICIAL
endif

# Set BLISS version
ifdef BLISS_RELEASE
    BLISS_BUILD_ZIP := Bliss-v$(VERSION)
else
    BLISS_BUILD_ZIP := Bliss-v$(VERSION)-$(LINEAGE_BUILD)-$(BLISS_BUILDTYPE)-$(BLISS_BUILD_VARIANT)-$(shell date +%Y%m%d)
endif

BLISS_DEVICE := $(LINEAGE_BUILD)
BLISS_VERSION := $(VERSION)
BLISS_DISPLAY_BUILDTYPE := $(BLISS_BUILDTYPE)
BLISS_FINGERPRINT := Bliss/$(VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d)
BLISS_BUILD_TIMESTAMP := $(shell date +%Y%m%d)
BLISS_BUILD_VERSION := $(BLISS_BUILD_ZIP)

TARGET_PRODUCT_SHORT := $(subst bliss_,,$(BLISS_BUILDTYPE))

# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Bliss version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.bliss.codename=$(BLISS_CODENAME) \
    ro.bliss.device=$(BLISS_DEVICE) \
    ro.bliss.version=$(BLISS_VERSION) \
    ro.bliss.build.status=$(BLISS_BUILDTYPE) \
    ro.bliss.fingerprint=$(BLISS_FINGERPRINT) \
    ro.bliss.static.version=$(BLISS_VERSION_STATIC) \
    ro.bliss.build.variant=$(BLISS_BUILD_VARIANT) \
    ro.bliss.build.timestamp=$(BLISS_BUILD_TIMESTAMP) \
    ro.bliss.build=$(BLISS_BUILD_ZIP)
