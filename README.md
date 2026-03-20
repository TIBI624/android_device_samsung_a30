# Samsung Galaxy A30 Device Tree for Android 16 (Evolution X)

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/TIBI624/android_device_samsung_a30/build.yml?branch=android-16&style=for-the-badge)](https://github.com/TIBI624/android_device_samsung_a30/actions)
[![License](https://img.shields.io/github/license/TIBI624/android_device_samsung_a30?style=for-the-badge)](LICENSE)
[![Android Version](https://img.shields.io/badge/Android-16-blue?style=for-the-badge&logo=android)](https://www.android.com/)
[![ROM Base](https://img.shields.io/badge/ROM-Evolution%20X-red?style=for-the-badge)](https://evolution-x.org/)

## 📱 Device Specifications

| Feature | Specification |
|---------|---------------|
| **Device Name** | Samsung Galaxy A30 |
| **Codename** | a30 |
| **Model Numbers** | SM-A305F, SM-A305G, SM-A305N, SM-A305FN |
| **SoC** | Samsung Exynos 7885 (14nm) |
| **CPU** | Octa-core (2x2.3 GHz Cortex-A73 & 6x1.7 GHz Cortex-A53) |
| **GPU** | Mali-G71 MP2 |
| **Memory** | 3GB / 4GB LPDDR4X |
| **Storage** | 32GB / 64GB (expandable via microSD) |
| **Display** | 6.4" Super AMOLED, 1080 x 2340 pixels (~403 ppi) |
| **Battery** | Li-Po 4000 mAh, non-removable |
| **Original OS** | Android 9.0 (Pie), One UI 1.1 |
| **Current OS** | Android 16 (Evolution X) |

## 🚀 Project Status

| Component | Status | Notes |
|-----------|--------|-------|
| **Boot** | ✅ Working | Kernel: Eureka R15.1.1 (4KB pages) |
| **Display** | ✅ Working | 1080x2340, 420 DPI |
| **Touch** | ✅ Working | Multi-touch supported |
| **WiFi** | ✅ Working | Broadcom BCM4375 |
| **Bluetooth** | ✅ Working | BT 5.0 |
| **Camera** | ⚠️ Partial | Rear working, Front may have issues |
| **Audio** | ✅ Working | Speaker, Headphone, Mic |
| **Sensors** | ✅ Working | Accelerometer, Gyro, Proximity |
| **GPS** | ✅ Working | GNSS support |
| **RIL** | ⚠️ Testing | Calls/SMS/Data - variant dependent |
| **Fingerprint** | ✅ Working | Rear-mounted |
| **Face Unlock** | ✅ Working | Software-based |
| **USB** | ✅ Working | MTP, ADB, Charging |
| **SELinux** | ⚠️ Permissive | Enforcing WIP |

## 🛠️ Build Instructions

### Prerequisites

- **OS**: Ubuntu 20.04 LTS or newer (64-bit)
- **RAM**: Minimum 16GB (32GB recommended)
- **Storage**: Minimum 100GB free space- **Python**: 3.8 or newer
- **Repo**: Latest version from Google

### Step 1: Initialize Repo

```bash
# Create working directory
mkdir android16_a30
cd android16_a30

# Initialize Evolution X repo
repo init -u https://github.com/Evolution-X/manifest.git -b fourteen

# Add local manifest for device tree
mkdir -p .repo/local_manifests
cp path/to/a30.xml .repo/local_manifests/
```

### Step 2: Sync Sources

```bash
# Sync all repositories
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
```

### Step 3: Setup Environment

```bash
# Source build environment
source build/envsetup.sh

# Select device configuration
lunch evolution_a30-userdebug
```

### Step 4: Build

```bash
# Build boot image (for testing)
mka bootimage -j$(nproc --all)

# Build full ROM
mka bacon -j$(nproc --all)

# Output location
# out/target/product/a30/EvolutionX-*.zip
```

## 📋 Dependencies
This device tree requires the following repositories (see `evolution.dependencies`):

| Repository | Path | Purpose |
|------------|------|---------|
| [universal7885-common](https://github.com/eurekadevelopment/android_device_samsung_exynos7885) | device/samsung/universal7885-common | Common HAL & configs |
| [Eureka Kernel](https://github.com/eurekadevelopment/Eureka-Kernel-Exynos7885-Q-R-S) | kernel/samsung/universal7885 | Kernel sources |
| [Vendor Blobs](https://github.com/AndroidBlobs/vendor_samsung_a30) | vendor/samsung/a30 | Proprietary binaries |

## ⚠️ Important Notes

### 16KB Page Size Compatibility

This device tree implements **Android 16 16KB page alignment** while maintaining **4KB kernel pages** for blob compatibility:

```makefile
# BoardConfig.mk
BOARD_KERNEL_PAGESIZE := 4096              # Kernel stays at 4KB
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 16384   # ELF alignment for Android 16
```

This allows Android 16 to work with legacy Samsung blobs that require 4KB pages.

### Low RAM Optimizations

For 3GB/4GB RAM variants, the following optimizations are enabled:

```makefile
MALLOC_SVELTE := true
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
ART_USE_SMALL_BCP := true
ro.config.low_ram=true
```

### AVB & Dynamic Partitions

- **AVB**: Disabled by default (enable after testing)
- **Dynamic Partitions**: Disabled for stability (static partitions recommended)

## 🔧 Extracting Vendor Blobs

```bash
# Connect device with stock firmware (if you have physical device)
adb root
adb wait-for-device

# Run extraction script
cd device/samsung/a30
./extract-files.sh

# Or from stock firmware zip./extract-files.sh /path/to/stock/firmware
```

**Note**: If building on cloud/remote machine without physical device, download stock firmware and extract blobs locally before pushing to your build environment.

## 📞 Support & Development

| Platform | Link |
|----------|------|
| **GitHub Issues** | [Report bugs here](https://github.com/TIBI624/android_device_samsung_a30/issues) |
| **XDA Thread** | [Coming soon](https://forum.xda-developers.com/) |
| **Evolution X Telegram** | [Evolution X Official](https://t.me/evolutionxofficial) |
| **Eureka Development** | [Eureka Telegram](https://t.me/eureka_kernel) |

## 📜 License

This device tree is licensed under the **Apache License 2.0**. See [LICENSE](LICENSE) for details.