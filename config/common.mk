PRODUCT_BRAND ?= bliss

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

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Default sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg \
    ro.config.ringtone=Themos.ogg

# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0

#Chromium libs
ifeq ($(USE_CHROMIUM), true)
  ifeq ($(CHROMIUM_X86), true)
    PRODUCT_COPY_FILES += \
        vendor/bliss/Chromium/x86/libs/libchrome.so:system/app/Chromium/lib/x86/libchrome.so \
        vendor/bliss/Chromium/x86/libs/libchromium_android_linker.so:system/app/Chromium/lib/x86/libchromium_android_linker.so
  else
    PRODUCT_COPY_FILES += \
        vendor/bliss/Chromium/arm/libs/libchrome.so:system/app/Chromium/lib/arm/libchrome.so \
        vendor/bliss/Chromium/arm/libs/libchromium_android_linker.so:system/app/Chromium/lib/arm/libchromium_android_linker.so
  endif
    PRODUCT_PACKAGES += \
        Chromium
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bliss/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bliss/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/bliss/prebuilt/common/bin/whitelist:system/addon.d/whitelist \
    vendor/bliss/prebuilt/bin/blacklist:system/addon.d/blacklist \
    vendor/bliss/prebuilt/common/bin/50-bliss.sh:system/addon.d/50-bliss.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/bliss/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/bliss/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/bliss/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.bliss.rc:root/init.bliss.rc \
    vendor/bliss/prebuilt/common/etc/init.blissupdater.rc:system/etc/init/init.blissupdater.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/bliss/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/bliss/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# World APN list
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

#permissions
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/etc/permissions/privapp-permissions-bliss.xml:system/etc/permissions/privapp-permissions-bliss.xml \
    vendor/bliss/prebuilt/etc/permissions/privapp-permissions-elgoog.xml:system/etc/permissions/privapp-permissions-elgoog.xml


# whitelist packages for location providers not in system
PRODUCT_PROPERTY_OVERRIDES += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/bliss/overlay/common

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# by default, do not update the recovery with system updates
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.recovery_update=false

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
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
# Fonts
PRODUCT_COPY_FILES += \
    vendor/bliss/fonts/GoogleSans-Regular.ttf:system/fonts/GoogleSans-Regular.ttf \
    vendor/bliss/fonts/GoogleSans-Medium.ttf:system/fonts/GoogleSans-Medium.ttf \
    vendor/bliss/fonts/GoogleSans-MediumItalic.ttf:system/fonts/GoogleSans-MediumItalic.ttf \
    vendor/bliss/fonts/GoogleSans-Italic.ttf:system/fonts/GoogleSans-Italic.ttf \
    vendor/bliss/fonts/GoogleSans-Bold.ttf:system/fonts/GoogleSans-Bold.ttf \
    vendor/bliss/fonts/GoogleSans-BoldItalic.ttf:system/fonts/GoogleSans-BoldItalic.ttf


# Bliss Versioning System
-include vendor/bliss/config/versions.mk

# Bliss Packages
-include vendor/bliss/config/bliss_packages.mk

$(call inherit-product-if-exists, vendor/bliss/prebuilt/common/app/Android.mk)
$(call inherit-product-if-exists, vendor/bliss/prebuilt/common/apk/prebuilt.mk)
$(call inherit-product-if-exists, vendor/bliss/google/Android.mk)
$(call inherit-product-if-exists, vendor/bliss/prebuilt/common/privapp/Android.mk)
$(call inherit-product-if-exists, vendor/extra/product.mk)

# Prebuilt vi editor
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/vi:system/bin/vi

# Boot Animation
PRODUCT_PACKAGES += \
    bootanimation.zip

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
SELINUX_IGNORE_NEVERALLOWS := true
endif
