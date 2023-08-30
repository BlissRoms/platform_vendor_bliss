# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= Bliss

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bliss/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bliss/prebuilt/common/bin/50-bliss.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-bliss.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-bliss.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/bliss/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/bliss/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/lineage-sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/lineage-sysconfig.xml

# Font service Permissions
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/privapp-permissions-bliss-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-bliss-system_ext.xml \

# Bliss-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init/init.bliss-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.bliss-system_ext.rc \
    vendor/bliss/prebuilt/common/etc/init/init.bliss-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.bliss-updater.rc \
    vendor/bliss/prebuilt/common/etc/init/smartcharge-init.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/smartcharge-init.rc \
    vendor/bliss/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Lineage specific permissions 
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.android.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Include AOSP audio files
include vendor/bliss/config/aosp_audio.mk

# Include Bliss audio files
include vendor/bliss/config/bliss_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/bliss/config/lineage_sdk_common.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# StitchImage
PRODUCT_PACKAGES += \
    StitchImage

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Livedisplay
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-lineagehw.xml

# Omadm
PRODUCT_COPY_FILES += \
    vendor/bliss/config/permissions/privapp-permissions-omadm.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-omadm.xml

# Bliss Bootanimation
-include vendor/bliss/config/bootanimation.mk

# Bliss Versioning System
-include vendor/bliss/config/versions.mk

# Bliss Packages
-include vendor/bliss/config/bliss_packages.mk

# Bliss Prebuilts
-include vendor/prebuilts/bliss_prebuilts.mk

# Bliss Overlays
-include vendor/overlays/bliss_overlays.mk

# Gapps
ifeq ($(BLISS_BUILD_VARIANT), gapps)
$(call inherit-product, vendor/gapps/products/gms.mk)
endif

# PixelGapps
ifeq ($(BLISS_BUILD_VARIANT), pixelgapps)
$(call inherit-product, vendor/gms/products/gms.mk)
endif

# Plugins
#include packages/apps/Plugins/plugins.mk

# FOSS Apps
ifeq ($(BLISS_BUILD_VARIANT), foss)
$(call inherit-product, vendor/foss/foss.mk)
endif

# Go-gapps
ifeq ($(BLISS_BUILD_VARIANT), goapps)
$(call inherit-product, vendor/gapps-go/gapps-go.mk)
endif

# MicroG
ifeq ($(BLISS_BUILD_VARIANT), microg)
$(call inherit-product, vendor/microg/products/gms.mk)
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/bliss/config/partner_gms.mk

# System
persist.sys.binary_xml=false

# Quick Tap
ifeq ($(TARGET_SUPPORTS_QUICK_TAP),true)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml
endif
