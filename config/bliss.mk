# Bliss Packages
PRODUCT_PACKAGES += \
    GameSpace \
    LMOFreeform \
    LMOFreeformSidebar \
    OmniJaws

# PIF values
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=oriole_beta \
    persist.sys.pihooks_DEVICE?=oriole \
    persist.sys.pihooks_ID?=BP22.250221.013 \
    persist.sys.pihooks_SECURITY_PATCH?=2025-03-05 \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=21

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/oriole_beta/oriole:16/BP22.250221.013/13218340:user/release-keys" \
    PihooksGmsModel="Pixel 6"

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Face Unlock
ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED),false)
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Keys
ifeq ($(BLISS_BUILD_TYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
