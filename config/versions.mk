# Versioning System For Bliss
# Bliss RELEASE VERSION
BLISS_VERSION_MAJOR = 18
BLISS_VERSION_MINOR = 0
BLISS_CODENAME = Voyager
BLISS_VERSION_MAINTENANCE = Beta

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

# Bliss Android version
BLISS_VERSION_STATIC = 15.0

# Set Bliss Build Variant
BLISS_BUILD_VARIANT ?= vanilla

ifdef BLISS_VERSION_MAINTENANCE
    VERSION := $(BLISS_VERSION_MAJOR).$(BLISS_VERSION_MINOR)-$(BLISS_VERSION_MAINTENANCE)
else
    VERSION := $(BLISS_VERSION_MAJOR).$(BLISS_VERSION_MINOR)
endif

TARGET_PRODUCT_SHORT := $(subst bliss_,,$(BLISS_BUILDTYPE))

# Set BLISS_BUILDTYPE
ifdef BLISS_NIGHTLY
    BLISS_BUILDTYPE := NIGHTLY
endif
ifdef BLISS_EXPERIMENTAL
    BLISS_BUILDTYPE := EXPERIMENTAL
endif
#ifdef BLISS_MAINTENANCE
#    BLISS_BUILDTYPE := MAINTENANCE
#endif
# Set Unofficial if no buildtype set (Buildtype should ONLY be set by BLISS Devs!)
ifdef BLISS_BUILDTYPE
else
    BLISS_BUILDTYPE := UNOFFICIAL
endif

# Set BLISS version
ifdef BLISS_RELEASE
    BLISS_BUILD_ZIP := Bliss-v$(VERSION)
else
    BLISS_BUILD_ZIP := Bliss-v$(VERSION)-$(BLISS_BUILD)-$(BLISS_BUILDTYPE)-$(BLISS_BUILD_VARIANT)-$(shell date +%Y%m%d)
endif

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

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.bliss.codename=$(BLISS_CODENAME) \
  ro.bliss.device=$(BLISS_DEVICE) \
  ro.bliss.version=$(BLISS_VERSION) \
  ro.bliss.build.status=$(BLISS_BUILDTYPE) \
  ro.bliss.changelog.version=Changelog-$(BLISS_VERSION) \
  ro.bliss.fingerprint=$(BLISS_FINGERPRINT) \
  ro.bliss.static.version=$(BLISS_VERSION_STATIC) \
  ro.bliss.build.variant=$(BLISS_BUILD_VARIANT) \
  ro.bliss.build.timestamp=$(BLISS_BUILD_TIMESTAMP) \
  ro.bliss.build=$(BLISS_BUILD_ZIP)
