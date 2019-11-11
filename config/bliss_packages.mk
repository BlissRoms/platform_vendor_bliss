# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip

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

# Overlays
PRODUCT_PACKAGES += \
    NexusLauncherReleaseOverlay

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Bliss Packages
PRODUCT_PACKAGES += \
    LatinIME \
    DeskClock \
    Recorder \
    ThemePicker \
    BlissUpdater \
    BlissPapers \
    SettingsIntelligenceGooglePrebuilt \
    NexusLauncherRelease \
    GalleryGoPrebuilt \
    PixelThemes \
    AboutBliss \
    BlissStatistics \
    Contacts \
    Dialer

# Accents
PRODUCT_PACKAGES += \
    AccentColorYellowOverlay \
    AccentColorVioletOverlay \
    AccentColorTealOverlay \
    AccentColorRedOverlay \
    AccentColorQGreenOverlay \
    AccentColorPinkOverlay \
    AccentColorLightPurpleOverlay \
    AccentColorIndigoOverlay \
    AccentColorFlatPinkOverlay \
    AccentColorCyanOverlay \
    AccentColorBlueGrayOverlay
