# Extra tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

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

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Bliss Packages
PRODUCT_PACKAGES += \
    CustomDoze \
    LatinIME \
    DeskClock \
    ThemePicker \
    BlissUpdater \
    BlissPapers \
    OPScreenRecorder \
    NexusWallpapersStubPrebuilt2019Static \
    GalleryGoPrebuilt \
    AboutBliss \
    BlissStatistics \
    Contacts \
    Dialer \
    OmniJaws \
    WeatherIcons \
    OmniStyle \
    SoundPickerPrebuilt \
    SettingsIntelligenceGooglePrebuilt

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock \
    StatusBarStockSysUI \
    ImmersiveMode

# PixelSetupWizard overlay
PRODUCT_PACKAGES += \
    PixelSetupWizardOverlay

# Snap Camera
PRODUCT_PACKAGES += \
    Snap

# Long Screenshot
PRODUCT_PACKAGES += \
    StitchImage

ifeq ($(TARGET_USES_LAWNCHAIR),true)
PRODUCT_PACKAGES += \
    Lawnchair

PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/bliss/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml
else
PRODUCT_PACKAGES += \
    Launcher3 \
    Launcher3QuickStep
endif

# OmniJaws Permission
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/org.omnirom.omnijaws.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.omnirom.omnijaws.xml

# Bliss System Permission
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/privapp-permissions-bliss-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-bliss-system.xml

# Bliss Product Permission
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/privapp-permissions-bliss-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-bliss.xml \
    vendor/bliss/config/permissions/privapp-permissions-google_prebuilt.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google_prebuilt.xml
