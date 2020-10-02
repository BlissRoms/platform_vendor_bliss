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

# Bliss Packages
PRODUCT_PACKAGES += \
    LatinIME \
    Recorder \
    Launcher3 \
    Launcher3QuickStep \
    BlissUpdater

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Themes
PRODUCT_PACKAGES += \
    LineageThemesStub \
    ThemePicker
