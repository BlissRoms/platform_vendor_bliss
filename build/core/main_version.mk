ADDITIONAL_BUILD_PROPERTIES += \
  ro.bliss.version=$(BLISS_DISPLAY_VERSION) \
  ro.bliss.build.status=$(BLISS_BUILDTYPE) \
  ro.bliss.changelog.version=Changelog-$(BLISS_VERSION) \
  ro.bliss.fingerprint=$(BLISS_FINGERPRINT) \
  ro.bliss.static.version=$(BLISS_VERSION_STATIC) \
  ro.bliss.build.variant=$(BLISS_BUILD_VARIANT)
