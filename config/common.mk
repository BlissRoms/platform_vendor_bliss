# Brand
PRODUCT_BRAND ?= bliss

# Local path for prebuilts
LOCAL_PATH:= vendor/bliss/prebuilt/common

# Common build prop overrides 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dataroaming=false \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    keyguard.no_require_sim=true \
    ro.facelock.black_timeout=400 \
    ro.facelock.det_timeout=1500 \
    ro.facelock.rec_timeout=2500 \
    ro.facelock.lively_timeout=2500 \
    ro.facelock.est_max_time=600 \
    ro.facelock.use_intro_anim=false \
    ro.build.selinux=1 \
    ro.adb.secure=1 \
    persist.sys.dun.override=0

# Common overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/bliss/overlay/common

# Proprietary latinime lib needed for swyping
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# Enable sip+voip on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Camera effects
ifneq ($(filter bullhead angler,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    $(LOCAL_PATH)/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    $(LOCAL_PATH)/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd
endif

# Bootanimation support
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
PRODUCT_BOOTANIMATION := vendor/bliss/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip
else
PRODUCT_BOOTANIMATION := vendor/bliss/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif

PRODUCT_COPY_FILES += \
    $(PRODUCT_BOOTANIMATION):system/media/bootanimation.zip

endif

# Bliss Versioning System
-include vendor/bliss/config/versions.mk

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/bliss/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/bliss/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/bliss/prebuilt/bin/blacklist:system/addon.d/blacklist

# SuperSU
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    $(LOCAL_PATH)/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Bliss Custom Apps
PRODUCT_PACKAGES += \
masquerade

