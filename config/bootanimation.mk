# Copyright (C) 2014-2025 The BlissRoms Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Bootanimation Configuration

BOOTANIMATION_PATH := vendor/bliss/prebuilt/common/bootanimation

# Supported bootanimation resolutions
SUPPORTED_BOOTANIM_RES := 720 768 800 1080 1200 1440

# Default to 1080p if not specified
TARGET_BOOT_ANIMATION_RES ?= 1080

# Use resolution-specific bootanimation if supported, otherwise fallback
ifneq ($(filter $(TARGET_BOOT_ANIMATION_RES),$(SUPPORTED_BOOTANIM_RES)),)
    PRODUCT_COPY_FILES += $(BOOTANIMATION_PATH)/$(TARGET_BOOT_ANIMATION_RES).zip:system/media/bootanimation.zip
else
    $(warning Bootanimation resolution '$(TARGET_BOOT_ANIMATION_RES)' not supported, using default 1080p)
    PRODUCT_COPY_FILES += $(BOOTANIMATION_PATH)/1080.zip:system/media/bootanimation.zip
endif
