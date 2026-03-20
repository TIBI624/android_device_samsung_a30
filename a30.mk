#
# Copyright (C) 2026 TIBI624
# Copyright (C) 2026 Evolution X
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from a30 device
$(call inherit-product, device/samsung/a30/device.mk)

# Inherit some common Evolution X stuff.
$(call inherit-product, vendor/evolution/config/common_full_phone.mk)

# =============================================================================
# NECROMANCER OPTIMIZATIONS (LOW RAM & ANDROID 16)
# =============================================================================
MALLOC_SVELTE := true
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
ART_USE_SMALL_BCP := true
PRODUCT_USE_COMPRESSED_HDF5 := true

# ZRAM настройки
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zram.mark_idle_delay_mins=60 \
    ro.config.low_ram=true \
    persist.sys.zram_enabled=1

# Android 16 compatibility
PRODUCT_SHIPPING_API_LEVEL := 35

# Device identifier
PRODUCT_DEVICE := a30
PRODUCT_NAME := evolution_a30
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A305F
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

# Build Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PrivateFingerprint0=samsung/a30dd/a30:11/RP1A.200720.012/A305FXXU9CVL1:user/release-keys \
    TARGET_DEVICE=a30

BUILD_FINGERPRINT := samsung/a30dd/a30:11/RP1A.200720.012/A305FXXU9CVL1:user/release-keys