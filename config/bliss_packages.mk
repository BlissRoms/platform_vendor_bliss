# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Browser \
    libemoji \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Terminal \
    WallpaperPicker

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext \
    rcscommon

PRODUCT_BOOT_JARS += \
    telephony-ext \
    rcscommon

# RCS
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml \
    rcscommon.xml

# Snapdragon packages
PRODUCT_PACKAGES += \
    MusicFX \
    SnapdragonCamera \
    SnapdragonGallery \
    SnapdragonMusic

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    SoundRecorder

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# DU Utils Library
#PRODUCT_BOOT_JARS += \
#    org.dirtyunicorns.utils
#PRODUCT_PACKAGES += \
#    org.dirtyunicorns.utils

# Bliss Custom Apps
#PRODUCT_PACKAGES += \
#    ThemeInterfacer \
#    BlissOTA

# OmniRom packages
#PRODUCT_PACKAGES += \
#    OmniStyle \
#    OmniSwitch \
#    OmniJaws
