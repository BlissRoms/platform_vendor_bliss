# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# AOSP packages
ifeq ($(BLISS_BUILD_VARIANT), vanilla)
PRODUCT_PACKAGES += \
    Contacts \
    Dialer \
    Email \
    Etar \
    ExactCalculator \
    Exchange2 \
    messaging
endif

# Bliss Packages
PRODUCT_PACKAGES += \
    Aperture \
    DeskClock \
    LatinIME \
    Recorder \
    Profiles \
    BlissUpdater \
    Seedvault \
    WallpaperPicker2 \
    GameSpace \
    ParallelSpace \
    OmniJaws

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

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures
