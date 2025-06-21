#! /bin/bash

# ==========================================
# Android ROM Build Script for Xiaomi Munch 
# ==========================================

# ----------------------------------------
# Step 1: Remove Local Manifests
# ----------------------------------------
rm -rf .repo/local_manifests; \

# ----------------------------------------
# Step 2: Initialize Repo
# ----------------------------------------
# InfinityX
# ----------------------------------------
repo init -u https://github.com/ProjectInfinity-X/manifest -b 15 --git-lfs; \

# ----------------------------------------
# Step 3: Sync Sources
# ----------------------------------------
/opt/crave/resync.sh; \

# ----------------------------------------
# Step 4: Remove Old Device, Kernel, and Vendor Trees
# ----------------------------------------
rm -rf out/target/product/munch && rm -rf device/xiaomi/munch && rm -rf device/xiaomi/sm8250-common && rm -rf kernel/xiaomi/sm8250; \
rm -rf vendor/xiaomi/munch && rm -rf vendor/xiaomi/sm8250-common && rm -rf hardware/xiaomi && rm -rf hardware/dolby && rm -rf vendor/xiaomi/munch-firmware; \
rm -rf vendor/xiaomi/miuicamera && rm -rf packages/resources/devicesettings && rm -rf packages/apps/ViPER4AndroidFX; \

# ----------------------------------------
# Step 5: Clone Device Trees
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/device_xiaomi_munch device/xiaomi/munch; \
git clone https://github.com/UdayKumarChunduru/android_device_xiaomi_sm8250-common device/xiaomi/sm8250-common; \

# ----------------------------------------
# Step 6: Clone Vendor Trees
# ----------------------------------------
git clone https://gitlab.com/rik-x777/vendor_xiaomi_munch vendor/xiaomi/munch; \
git clone https://gitlab.com/rik-x777/vendor_xiaomi_sm8250-common vendor/xiaomi/sm8250-common; \

# ----------------------------------------
# Step 7: Clone Munch Firmware
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/android_vendor_xiaomi_munch-firmware vendor/xiaomi/munch-firmware; \

# ----------------------------------------
# Step 8: Clone Kernel Source
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/Realking_kernel_sm8250 kernel/xiaomi/sm8250; \

# ----------------------------------------
# Step 9: Clone Xiaomi Hardware Support
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/android_hardware_xiaomi hardware/xiaomi; \

# ----------------------------------------
# Step 10: Clone Dolby Hardware
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/android_hardware_dolby hardware/dolby; \

# ----------------------------------------
# Step 11: Clone Device Settings
# ----------------------------------------
git clone https://github.com/PocoF3Releases/packages_resources_devicesettings packages/resources/devicesettings; \

# ----------------------------------------
# Step 12: Clone ViPER4AndroidFX
# ----------------------------------------
git clone https://gitlab.com/rik-x777/packages_apps_ViPER4AndroidFX packages/apps/ViPER4AndroidFX; \

# ----------------------------------------
# Step 13: Clone MIUI Camera
# ----------------------------------------
git clone https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera vendor/xiaomi/miuicamera; \

# ----------------------------------------
# Step 14: Setup Build Environment and Start Build
# ----------------------------------------
source build/envsetup.sh; \
lunch infinity_munch-user && mka bacon; \
