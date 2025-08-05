# Bliss Packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
#    GameSpace \
#    LMOFreeform \
#    LMOFreeformSidebar \
#    OmniJaws

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-bliss-product.xml

# Disable async MTE on a few processes
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.arm64.memtag.app.com.android.se=off \
    persist.arm64.memtag.app.com.google.android.bluetooth=off \
    persist.arm64.memtag.app.com.android.nfc=off \
    persist.arm64.memtag.process.system_server=off

# Disable default frame rate limit for games
PRODUCT_PRODUCT_PROPERTIES += \
    debug.graphics.game_default_frame_rate.disabled=true

ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED),false)
#PRODUCT_PACKAGES += \
#    FaceUnlock

#PRODUCT_SYSTEM_EXT_PROPERTIES += \
#    ro.face.sense_service=true

#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Keys
ifeq ($(BLISS_BUILD_TYPE),OFFICIAL)
include vendor/bliss-priv/keys/keys.mk
else
-include vendor/bliss-priv/keys/keys.mk
endif
