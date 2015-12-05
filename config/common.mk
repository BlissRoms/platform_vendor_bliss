PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/bliss/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/bliss/prebuilt/common/bin/50-bliss.sh:system/addon.d/50-bliss.sh \
    vendor/bliss/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Bliss-specific init file
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.local.rc:root/init.bliss.rc

# AdAway App
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/AdAway/AdAway.apk:system/priv-app/AdAway/AdAway.apk

# KernelAdiutor
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/KernelAdiutor/KernelAdiutor.apk:system/app/KernelAdiutor/KernelAdiutor.apk

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/bliss/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/bliss/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/bliss/prebuilt/common/bin/sysinit:system/bin/sysinit


# Bliss Audio Mods
-include vendor/bliss/config/bliss_audio_mod.mk

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Other packages
PRODUCT_PACKAGES += \
    BlissOTA \
    BlissSettings

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimLauncher \
    LatinIME \
    BluetoothExt

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/common

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/bliss/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif
endif

# BLISS Versioning System
-include vendor/bliss/config/versions.mk

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.bliss.version=$(BLISS_VERSION)

# Team Bliss OTA Updater
ifeq ($(BLISS_DONATE),)
  BLISS_DONATE =: 
endif
BLISS_OTA_BUILDDIR := Official
ifeq ($(BLISS_BUILDTYPE),NIGHTLY)
  BLISS_OTA_BUILDDIR := Nightlies
endif
BLISS_BASE_URL    := http://downloads.blissroms.com/Bliss
ifeq ($(BLISS_DEVICE_URL),)
  BLISS_DEVICE_URL := $(BLISS_BASE_URL)/$(BLISS_OTA_BUILDDIR)/$(TARGET_DEVICE)
endif
BLISS_OTA_VERSION := $(shell date +%Y%m%d%H)
BLISS_ROM_NAME    := Bliss

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.systemname=$(BLISS_ROM_NAME) \
    ro.ota.version=$(BLISS_OTA_VERSION) \
    ro.ota.device=$(TARGET_DEVICE) \
    ro.ota.manifest=$(BLISS_DEVICE_URL)/ota$(BLISS_OTA_XMLVER).xml

export BLISS_OTA_ROM=$(BLISS_ROM_NAME)
export BLISS_OTA_VERNAME=$(BLISS_VERSION)
export BLISS_OTA_VER=$(BLISS_OTA_VERSION)
export BLISS_OTA_URL=$(BLISS_DEVICE_URL)/$(BLISS_VERSION).zip

EXTENDED_POST_PROCESS_PROPS := vendor/bliss/tools/bliss_process_props.py

$(call prepend-product-if-exists, vendor/extra/product.mk)
