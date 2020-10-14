# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# AOSP packages
ifeq ($(BLISS_BUILD_VARIANT), vanilla)
PRODUCT_PACKAGES += \
    Contacts \
    Calendar \
    DeskClock \
    Dialer \
    Email \
    ExactCalculator \
    Exchange2 \
    LiveWallpapersPicker \
    messaging \
    SimpleGalleryPro \
    WallpaperPicker2
endif

# Bliss Packages
PRODUCT_PACKAGES += \
    LatinIME \
    Recorder \
    LineageParts \
    LineageSettingsProvider \
    LockClock \
    PixelThemesStub2020_midyear \
    Phonograph \
    Profiles \
    SettingsIntelligenceGooglePrebuilt \
    WallpapersBReel2020a \
    WeatherProvider \
    BlissUpdater

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

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
    libsepol \
    nano \
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

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Themes
PRODUCT_PACKAGES += \
    LineageThemesStub \
    LineageBlackTheme \
    ThemePicker
