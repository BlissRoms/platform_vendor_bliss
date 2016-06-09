# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

# Include Bliss audio files
include vendor/bliss/config/bliss_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

# Inherit common CM stuff
$(call inherit-product, vendor/bliss/config/common_mini.mk)

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/bliss/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
