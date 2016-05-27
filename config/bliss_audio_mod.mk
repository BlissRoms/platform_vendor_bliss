# Copyright (C) 2016 BlissRoms
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

# ViPER4Android
ifeq (viper, $(strip $(BLISS_AUDIO_MOD)))
PRODUCT_COPY_FILES += \
    vendor/bliss/prebuilt/common/app/ViPER4Android.apk:system/priv-app/ViPER4Android/ViPER4Android.apk \
    vendor/bliss/prebuilt/common/viper/etc/audio_effects.conf:system/etc/audio_effects.conf \
    vendor/bliss/prebuilt/common/viper/lib/soundfx/libeffectproxy.so:system/lib/soundfx/libeffectproxy.so \
    vendor/bliss/prebuilt/common/viper/lib/soundfx/libv4a_fx_ics.so:system/lib/soundfx/libv4a_fx_ics.so \
    vendor/bliss/prebuilt/common/viper/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf
else
# AudioFX
PRODUCT_PACKAGES += \
    AudioFX
endif
