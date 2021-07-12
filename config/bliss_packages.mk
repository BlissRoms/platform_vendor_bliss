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
    messaging \
    SimpleGalleryPro
endif

# Bliss Packages
PRODUCT_PACKAGES += \
    DeskClock \
    LatinIME \
    Recorder \
    LineageParts \
    LineageSettingsProvider \
    Phonograph \
    Profiles \
    BlissUpdater \
    Seedvault \
    WallpaperPicker2 \
    Flipendo \
    OmniStyle

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

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
    setcap \
    unrar \
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
    Stk

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Themes
PRODUCT_PACKAGES += \
    LineageThemesStub \
    LineageBlackTheme \
    ThemePicker
