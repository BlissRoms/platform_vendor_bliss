#
# 2017 Bliss Roms - Adapted from Android-x86 Project
# Original Copyright (C) 2011-2015 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

LOCAL_PATH := $(call my-dir)
# Prebuilt Packages
PRODUCT_PACKAGES += \
    AmbientSensePrebuilt

# AmbientSense
PRODUCT_COPY_FILES +=  \
    vendor/bliss/prebuilt/common/etc/ambient/matcher_tah.leveldb:system/etc/ambient/matcher_tah.leveldb

