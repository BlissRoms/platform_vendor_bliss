# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= Bliss

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

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bliss/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bliss/prebuilt/common/bin/50-bliss.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-bliss.sh \
    vendor/bliss/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/bliss/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/lineage-sysconfig.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lineage-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner \
    vendor/bliss/prebuilt/common/bin/sysinit:$(TARGET_COPY_OUT_SYSTEM)/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.d/90userinit:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/90userinit
endif

# Copy all Bliss-specific init rc files
$(foreach f,$(wildcard vendor/bliss/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Lineage specific permissions
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.lineageos.android.xml \
    vendor/bliss/config/permissions/privapp-permissions-lineage-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lineage.xml \
    vendor/bliss/config/permissions/privapp-permissions-lineage-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-lineage.xml \
    vendor/bliss/config/permissions/privapp-permissions-cm-legacy.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-cm-legacy.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/lineage-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/lineage-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lineage-power-whitelist.xml

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml

# Default ringtone
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=Orion.ogg

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Include AOSP audio files
include vendor/bliss/config/aosp_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/bliss/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/bliss/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

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

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/bliss/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/bliss/overlay/common

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

# Misc Packages
-include vendor/bliss/config/misc_packages.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/bliss/config/partner_gms.mk
