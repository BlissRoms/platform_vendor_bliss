# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

# Include Bliss audio files
include vendor/bliss/config/bliss_audio.mk
PRODUCT_SIZE := full


# Optional CM packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PhotoTable \
    SoundRecorder \
    PhotoPhase \
    Screencast

# Extra tools in CM
PRODUCT_PACKAGES += \
    7z \
    lib7z \
    bash \
    bzip2 \
    curl \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip
