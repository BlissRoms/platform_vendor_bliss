# Misc Tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bzip2 \
    bash \
    curl \
    fsck.exfat \
    fsck.ntfs \
    gdbserver \
    htop \
    libemoji \
    libsepol \
    lib7z \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs \
    micro_bench \
    oprofiled \
    powertop \
    pigz \
    sqlite3 \
    strace \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk

# Mms depends on SoundRecorder for recorded audio messages
#PRODUCT_PACKAGES += \
#    SoundRecorder

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Substratum
#PRODUCT_PACKAGES += \
#    SubstratumService

# Themes
#PRODUCT_PACKAGES += \
#    Stock \
#    DarkBlissTheme \
#    BlackBlissTheme \
#    PixelTheme \
#    SluttyPinkTheme \
#    DarknessMeisterTheme \
#    SmokedGreenTheme \
#    AmberTheme \
#    Bl4ckAndYell0Theme \
#    GboardDarkTheme

# Misc Packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    LiveWallpapersPicker \
    LatinIME \
    Terminal

# Additional apps
PRODUCT_PACKAGES += \
    OmniSwitch \
    OmniJaws \
    OmniStyle \
    OmniChange

PRODUCT_PACKAGES += \
    NotificationsDark \
    NotificationsLight \
    DocumentsUITheme \
    NotificationsPrimary \
    NotificationsBlack \
    DialerTheme \
    TelecommTheme

PRODUCT_PACKAGES += \
    AccentSluttyPink \
    AccentPixel \
    AccentGoldenShower \
    AccentDeepOrange \
    AccentWhite \
    AccentTeal \
    AccentFromHell \
    AccentBlueMonday \
    AccentSmokingGreen \
    AccentDeadRed \
    AccentRottenOrange \
    AccentDeepPurple \
    AccentBliss

PRODUCT_PACKAGES += \
    PrimaryAlmostBlack \
    PrimaryBlack \
    PrimaryBliss \
    PrimaryWhite \
    PrimaryColdWhite \
    PrimaryWarmWhite \
    PrimaryDarkBlue
    
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
