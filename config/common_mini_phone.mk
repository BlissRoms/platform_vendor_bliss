# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

# Include Bliss audio files
include vendor/bliss/config/bliss_audio.mk

# Required Bliss packages
PRODUCT_PACKAGES += \
    LatinIME

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/bliss/prebuilt/common/bootanimation/320.zip:system/media/bootanimation.zip
endif

$(call inherit-product, vendor/bliss/config/telephony.mk)
