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
# repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 15 -g default,-mips,-darwin,-notdefault; \

# ----------------------------------------
# Step 3: Sync Sources
# ----------------------------------------
/opt/crave/resync.sh; \

# ----------------------------------------
# Step 4: Remove Old Device, Kernel, and Vendor Trees
# ----------------------------------------
rm -rf out/target/product/munch && rm -rf device/xiaomi/munch && rm -rf device/xiaomi/sm8250-common && rm -rf kernel/xiaomi/sm8250 && rm -rf kernel/xiaomi/munch; \
rm -rf vendor/xiaomi/munch && rm -rf vendor/xiaomi/sm8250-common && rm -rf hardware/xiaomi && rm -rf hardware/dolby && rm -rf vendor/xiaomi/munch-firmware; \
rm -rf vendor/xiaomi/miuicamera && rm -rf packages/resources/devicesettings && rm -rf packages/apps/ViPER4AndroidFX && rm -rf vendor/bcr; \

# ----------------------------------------
# Step 5: Clone Device Trees
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/android_device_xiaomi_munch device/xiaomi/munch; \

# ----------------------------------------
# Step 6: Clone Vendor Trees
# ----------------------------------------
git clone https://github.com/munch-devs/android_vendor_xiaomi_munch vendor/xiaomi/munch; \

# ----------------------------------------
# Step 7: Clone Munch Firmware
# ----------------------------------------
git clone https://github.com/UdayKumarChunduru/android_vendor_xiaomi_munch-firmware vendor/xiaomi/munch-firmware; \

# ----------------------------------------
# Step 8: Clone Kernel Source
# ----------------------------------------
# git clone https://github.com/UdayKumarChunduru/Realking_kernel_sm8250 -b m-staging kernel/xiaomi/sm8250; \
git clone https://github.com/munch-devs/kernel_xiaomi_munch -b munch-ksu-susfs kernel/xiaomi/munch; \
# git clone https://gitlab.com/rik-x777/kernel_xiaomi_sm8250 kernel/xiaomi/sm8250; \
# git clone https://github.com/SenseiiX/fusionX_sm8250 -b nxt-a16 kernel/xiaomi/sm8250; \
# cd kernel/xiaomi/sm8250 && git submodule init && git submodule update && rm -rf KernelSU-Next/userspace/su && cd ../../..; \

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
# Step 13: Clone BCR
# ----------------------------------------
git clone https://github.com/munch-devs/android_vendor_bcr vendor/bcr; \

# ----------------------------------------
# Step 14: Clone MIUI Camera
# ----------------------------------------
git clone https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera vendor/xiaomi/miuicamera; \

# ----------------------------------------
# Step 15: Remove Old Keys and Clone Infinity-X Private Keys
# ----------------------------------------
rm -rf vendor/lineage-priv/keys && rm -rf vendor/infinity-priv/keys; \

git clone https://gitlab.com/rik-x777/keys.git -b inf vendor/infinity-priv/keys; \

# ----------------------------------------
# Step 16: Setup Build Environment and Start Build
# ----------------------------------------
# ----------------------------------------
# Step 16.1: Build Vanilla ROM
# ----------------------------------------
. build/envsetup.sh; \
lunch infinity_munch-user && mka bacon; \

# ----------------------------------------
# Step 16.2: Clear Old Output Directories
# ----------------------------------------
rm -rf out/target/product/vanilla out/target/product/gapps out/target/product/full_gapps; \

# ----------------------------------------
# Step 16.3: Rename Output to Vanilla
# ----------------------------------------
cd out/target/product && mv munch vanilla && cd ../../..; \

# ----------------------------------------
# Step 16.4: Reconfigure for Standard GApps
# ----------------------------------------
# cd device/xiaomi/munch && rm infinity_munch.mk && mv gapps.txt infinity_munch.mk && cd ../../..; \

# ----------------------------------------
# Step 16.5: Build Standard GApps ROM
# ----------------------------------------
# . build/envsetup.sh; \
# lunch infinity_munch-user && mka bacon; \

# ----------------------------------------
# Step 16.6: Rename Output to Standard GApps
# ----------------------------------------
# cd out/target/product && mv munch gapps && cd ../../..; \

# ----------------------------------------
# Step 16.7: Reconfigure for Full GApps
# ----------------------------------------
cd device/xiaomi/munch && rm infinity_munch.mk && mv full_gapps.txt infinity_munch.mk && cd ../../..; \

# ----------------------------------------
# Step 16.8: Build Full GApps ROM
# ----------------------------------------
. build/envsetup.sh; \
lunch infinity_munch-user && mka bacon; \

# ----------------------------------------
# Step 16.9: Rename Output to Full GApps
# ----------------------------------------
cd out/target/product && mv munch full_gapps && cd ../../..; \
