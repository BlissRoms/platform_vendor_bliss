# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Bliss Packages
PRODUCT_PACKAGES += \
    Aperture \
    AvatarPicker \
    BlissUpdater \
    BlissSystemUI \
    Contacts \
    Covers \
    Datura \
    DeskClock \
    Dialer \
    Email \
    Etar \
    ExactCalculator \
    Exchange2 \
    GameSpace \
    Glimpse \
    Jelly \
    LatinIME \
    LMOFreeform \
    LMOFreeformSidebar \
    messaging \
    OmniJaws \
    ParallelSpace \
    Profiles \
    Recorder \
    Seedvault \
    ThemesStub \
    Twelve \
    WallpaperPicker2 \
    WeatherIcons

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

# Extra tools in bliss
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Telephony packages
PRODUCT_PACKAGES += \
    Stk

# Themes
PRODUCT_PACKAGES += \
    ThemePicker

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    librs_jni

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# DesktopMode
PRODUCT_PACKAGES += \
    DesktopMode

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

$(call inherit-product-if-exists, packages/services/VncFlinger/product.mk)

# Disable default frame rate limit for games
PRODUCT_PRODUCT_PROPERTIES += \
    debug.graphics.game_default_frame_rate.disabled=true

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# Bliss specific permissions
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/privapp-permissions-bliss-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-bliss-product.xml
