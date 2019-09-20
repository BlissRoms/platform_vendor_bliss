PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true

# Default sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg \
    ro.config.ringtone=The_big_adventure.ogg

# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0

#Chromium libs
ifeq ($(USE_CHROMIUM), true)
  ifeq ($(CHROMIUM_X86), true)
    PRODUCT_COPY_FILES += \
        vendor/bliss/Chromium/x86/libs/libchrome.so:$(TARGET_COPY_OUT_SYSTEM)/app/Chromium/lib/x86/libchrome.so \
        vendor/bliss/Chromium/x86/libs/libchromium_android_linker.so:$(TARGET_COPY_OUT_SYSTEM)/app/Chromium/lib/x86/libchromium_android_linker.so
  else
    PRODUCT_COPY_FILES += \
        vendor/bliss/Chromium/arm/libs/libchrome.so:$(TARGET_COPY_OUT_SYSTEM)/app/Chromium/lib/arm/libchrome.so \
        vendor/bliss/Chromium/arm/libs/libchromium_android_linker.so:$(TARGET_COPY_OUT_SYSTEM)/app/Chromium/lib/arm/libchromium_android_linker.so
  endif
    PRODUCT_PACKAGES += \
        Chromium
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bliss/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bliss/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist \
    vendor/bliss/prebuilt/common/bin/whitelist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/whitelist \
    vendor/bliss/prebuilt/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist \
    vendor/bliss/prebuilt/common/bin/50-bliss.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-bliss.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/bliss/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/sysinit:$(TARGET_COPY_OUT_SYSTEM)/bin/sysinit \
    vendor/bliss/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner

# Copy all Bliss specific init rc files
$(foreach f,$(wildcard vendor/bliss/prebuilt/common/etc/init/*.rc),\
$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/bliss/prebuilt/common/media/LMprec_508.emd:$(TARGET_COPY_OUT_SYSTEM)/media/LMprec_508.emd \
    vendor/bliss/prebuilt/common/media/PFFprec_600.emd:$(TARGET_COPY_OUT_SYSTEM)/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

#permissions
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/permissions/privapp-permissions-bliss.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-bliss.xml \
    vendor/bliss/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml

# whitelist packages for location providers not in system
PRODUCT_PROPERTY_OVERRIDES += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/selective-spn-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/bliss/overlay/common

# Proprietary latinime libs needed for Keyboard swyping
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib64/libjni_latinime.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_latinime.so \
    vendor/bliss/prebuilt/common/lib64/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib/libjni_latinime.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinime.so \
    vendor/bliss/prebuilt/common/lib/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinimegoogle.so
endif

# by default, do not update the recovery with system updates
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.recovery_update=false

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_BLISS_CHARGER),true)
PRODUCT_PACKAGES += \
    bliss_charger_res_images \
    font_log.png \
    libhealthd.bliss
endif

# Squisher Location
SQUISHER_SCRIPT := vendor/bliss/tools/squisher

# Google fonts
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/product/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml \
    vendor/bliss/prebuilt/product/fonts/ArbutusSlab-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ArbutusSlab-Regular.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-BoldItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-BoldItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Bold.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Italic.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-MediumItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Medium.ttf \
    vendor/bliss/prebuilt/product/fonts/GoogleSans-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/GoogleSans-Regular.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-BoldItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-BoldItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-Bold.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-Italic.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-MediumItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-Medium.ttf \
    vendor/bliss/prebuilt/product/fonts/Lato-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Lato-Regular.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-BoldItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-BoldItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-Bold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-Bold.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-Italic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-Italic.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-MediumItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-Medium.ttf \
    vendor/bliss/prebuilt/product/fonts/Rubik-Regular.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/Rubik-Regular.ttf \
    vendor/bliss/prebuilt/product/fonts/ZillaSlab-MediumItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ZillaSlab-MediumItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/ZillaSlab-Medium.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ZillaSlab-Medium.ttf \
    vendor/bliss/prebuilt/product/fonts/ZillaSlab-SemiBoldItalic.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ZillaSlab-SemiBoldItalic.ttf \
    vendor/bliss/prebuilt/product/fonts/ZillaSlab-SemiBold.ttf:$(TARGET_COPY_OUT_PRODUCT)/fonts/ZillaSlab-SemiBold.ttf

# Bliss Versioning System
-include vendor/bliss/config/versions.mk

# Bliss Packages
-include vendor/bliss/config/bliss_packages.mk

# Google sounds
-include vendor/bliss/prebuilt/common/sounds/GoogleAudio.mk

# Prebuilt vi editor
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/vi:$(TARGET_COPY_OUT_SYSTEM)/bin/vi

# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
SELINUX_IGNORE_NEVERALLOWS := true
endif
