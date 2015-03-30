#
# Copyright (C) 2014 The BlissRoms Project
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
#

# BlissRoms OTA Updater
ifeq ($(BLISS_DONATE),)
  BLISS_DONATE =: http://goo.gl/tymMFo
endif
BLISS_OTA_BUILDDIR := Official
ifeq ($(BLISS_BUILDTYPE),NIGHTLY)
  BLISS_OTA_BUILDDIR := Nightlies
endif
BLISS_BASE_URL    := https://downloads.blissroms.com
BLISS_DEVICE_URL  := $(BLISS_BASE_URL)/$(BLISS_OTA_BUILDDIR)/$(BLISS_BUILD)
BLISS_OTA_VERSION := $(shell date +%Y%m%d)
BLISS_ROM_NAME    := BlissRoms

PRODUCT_PROPERTY_OVERRIDES = \
    ro.ota.systemname=$(BLISS_ROM_NAME) \
    ro.ota.version=$(BLISS_OTA_VERSION) \
    ro.ota.device=$(BLISS_BUILD) \
    ro.ota.manifest=$(BLISS_DEVICE_URL)/ota.xml

export BLISS_OTA_ROM=$(BLISS_ROM_NAME)
export BLISS_OTA_VERNAME=$(BLISS_VERSION)
export BLISS_OTA_VER=$(BLISS_OTA_VERSION)
export BLISS_OTA_URL=$(BLISS_DEVICE_URL)/$(BLISS_VERSION).zip
