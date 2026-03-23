# Samsung Galaxy A30 Device Tree for Android 16 (Evolution X)

[![Cirrus CI](https://img.shields.io/cirrus/build/TIBI624/android_device_samsung_a30?style=for-the-badge&logo=cirrusci)](https://cirrus-ci.com/github/TIBI624/android_device_samsung_a30)
[![License](https://img.shields.io/github/license/TIBI624/android_device_samsung_a30?style=for-the-badge)](LICENSE)
[![Android Version](https://img.shields.io/badge/Android-16-blue?style=for-the-badge&logo=android)](https://www.android.com/)
[![ROM Base](https://img.shields.io/badge/ROM-Evolution%20X-red?style=for-the-badge)](https://evolution-x.org/)

> 💡 **Want to fork this project?**  
> [![Fork on GitHub](https://img.shields.io/badge/Fork-This%20Repo-000?style=for-the-badge&logo=github)](https://github.com/TIBI624/android_device_samsung_a30/fork)  
> Don't like Evolution X? Fork this repo, tweak a few configs in `device/samsung/a30/` and `vendor/`, and build your own custom ROM! 🚀

---

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

---

## 🚀 Project Status

| Component | Status | Notes |
|-----------|--------|-------|
| **Boot** | ✅ Working | Kernel: Eureka R15-AOSP (4KB pages) |
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
---

## 🛠️ Build Instructions

### Prerequisites

| Requirement | Specification |
|-------------|---------------|
| **OS** | Ubuntu 20.04 LTS or newer (64-bit) |
| **RAM** | Minimum 16GB (32GB recommended) |
| **Storage** | Minimum 100GB free space |
| **Python** | 3.8 or newer |
| **Repo** | Latest version from Google |

---

### 🖥️ Option 1: Local Build (On Your Machine)

> ⚠️ **Important!** The file `local_manifest.xml` is already in the **root of this repository**.  
> Just copy it to the correct location before running `repo sync`:

```bash
# After repo init, but before repo sync:
cp local_manifest.xml .repo/local_manifests/a30.xml
```

#### Step-by-Step:

```bash
# 1. Create working directory
mkdir android16_a30
cd android16_a30

# 2. Initialize Evolution X repo
repo init -u https://github.com/Evolution-X/manifest.git -b vic

# 3. Copy local manifest (from this repo root)
mkdir -p .repo/local_manifests
cp /path/to/android_device_samsung_a30/local_manifest.xml .repo/local_manifests/a30.xml

# 4. Sync all repositories
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# 5. Setup environment
source build/envsetup.sh
lunch evolution_a30-userdebug

# 6. Build
mka bootimage -j$(nproc --all)      # For testing boot.imgmka bacon -j$(nproc --all)          # For full ROM

# 7. Output location
# out/target/product/a30/EvolutionX-*.zip
```

---

### 🤖 Option 2: Cirrus CI Build (Automatic)

> ✅ **Everything is pre-configured!** The `.cirrus.yml` file is in the repository root.  
> Build triggers automatically on:
> - Push to `android-16` branch
> - Pull Request creation

#### What Cirrus CI does:
| Step | Action |
|------|--------|
| 1 | Clones the repository |
| 2 | Initializes Evolution-X manifest (`vic` branch) |
| 3 | Copies `local_manifest.xml` to `.repo/local_manifests/` |
| 4 | Syncs all dependencies |
| 5 | Builds `boot.img`, `recovery.img`, `EvolutionX-*.zip` |
| 6 | Caches `ccache` for faster subsequent builds |

#### Build Artifacts:
- `boot.img` — Boot image
- `recovery.img` — Recovery image
- `EvolutionX-*.zip` — Final ROM zip

> 📌 **Note**: If the Cirrus CI badge shows "Repository not found", ensure `.cirrus.yml` exists in the repository root on the `android-16` branch.

---

## 📋 Dependencies

| Repository | Path | Purpose | Branch/Revision |
|------------|------|---------|-----------------|
| [Device Tree (A30)](https://github.com/TIBI624/android_device_samsung_a30) | device/samsung/a30 | Device-specific configs | `android-16` |
| [Common Tree (Exynos7885)](https://github.com/TIBI624/android_device_samsung_exynos7885) | device/samsung/exynos7885-common | Common HAL & configs | `android-15` |
| [Eureka Kernel](https://github.com/eurekadevelopment/Eureka-Kernel) | kernel/samsung/universal7885 | Kernel sources | `R15-AOSP` |
| [Vendor Blobs (A30)](https://github.com/AndroidBlobs/vendor_samsung_a30) | vendor/samsung/a30 | Proprietary binaries (Android 10) | `a30dd-user-10-QP1A.190711.020-A305FDDU4BTB3-release-keys` |

> ⚠️ **Important**: Use **exact branch names** as listed above — `master` or default branches will **not work**.

---

## 🔄 Adapting for Other ROMs

This device tree is configured for **Evolution X** by default, but can be easily adapted for other AOSP-based ROMs.
### What to Change:

| File | Evolution X | LineageOS | Pixel Experience | ArrowOS |
|------|-------------|-----------|------------------|---------|
| `device.mk` | `evolution_a30` | `lineage_a30` | `pe_a30` | `arrow_a30` |
| `BoardConfig.mk` | `TARGET_SUPPORTS_64_BIT_APPS := true` | Same | Same | Same |
| `AndroidProducts.mk` | `PRODUCT_MAKEFILES := evolution_a30` | `lineage_a30` | `pe_a30` | `arrow_a30` |
| `lunch` command | `evolution_a30-userdebug` | `lineage_a30-userdebug` | `pe_a30-userdebug` | `arrow_a30-userdebug` |
| Manifest branch | `-b vic` | `-b lineage-22.1` | `-b main` | `-b 16.0` |

### Quick Guide for Other ROMs:

```bash
# 1. Fork this repository
# 2. Edit device/samsung/a30/AndroidProducts.mk:
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/lineage_a30.mk  # Change from evolution_a30.mk

# 3. Edit device/samsung/a30/device.mk:
# Change all references from "evolution" to "lineage"

# 4. Initialize your ROM's manifest:
repo init -u https://github.com/LineageOS/android.git -b lineage-22.1

# 5. Copy local_manifest.xml:
cp local_manifest.xml .repo/local_manifests/a30.xml

# 6. Build:
source build/envsetup.sh
lunch lineage_a30-userdebug
mka bacon -j$(nproc --all)
```

### ⚠️ ROM Compatibility Notes:

| ROM | Compatibility | Notes |
|-----|---------------|-------|
| **Evolution X** | ✅ Native | Fully tested |
| **LineageOS** | ⚠️ Requires changes | Update vendor blobs if needed |
| **Pixel Experience** | ⚠️ Requires changes | Check proprietary files |
| **ArrowOS** | ⚠️ Requires changes | Minimal changes needed |
| **crDroid** | ⚠️ Requires changes | Based on LineageOS |

> 💡 **Tip**: Most changes are in `device.mk` and `AndroidProducts.mk`. Hardware configuration (`BoardConfig.mk`) usually stays the same across AOSP-based ROMs.

---

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

### ⚠️ Vendor Blobs Compatibility

> The vendor blobs are sourced from **Android 10 (Q)**.  
> When building for Android 16, some HALs may require adaptation.  
> If you encounter errors, check:
> - `device/samsung/a30/overlay/` for framework patches
> - `proprietary-files.txt` for missing libraries

---

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

---

## 📞 Support & Development

| Platform | Link |
|----------|------|
| **GitHub Issues** | [Report bugs here](https://github.com/TIBI624/android_device_samsung_a30/issues) |
| **XDA Thread** | [Coming soon](https://forum.xda-developers.com/) |
| **Evolution X Telegram** | [Evolution X Official](https://t.me/evolutionxofficial) |
| **Eureka Development** | [Eureka Telegram](https://t.me/eureka_kernel) |

---

## 📜 License

This device tree is licensed under the **Apache License 2.0**. See [LICENSE](LICENSE) for details.