#
# Copyright (C) 2022-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
include vendor/xiaomi/diting/BoardConfigVendor.mk

DEVICE_PATH := device/xiaomi/diting

BUILD_BROKEN_DUP_RULES := true
# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv9-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taro
TARGET_NO_BOOTLOADER := true

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default

# Kernel
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery

TARGET_KERNEL_ADDITIONAL_FLAGS := TARGET_PRODUCT=$(PRODUCT_DEVICE)
TARGET_KERNEL_SOURCE := kernel/xiaomi/diting
TARGET_KERNEL_CONFIG := diting_defconfig

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_VENDOR_RAMDISK_FRAGMENTS := dlkm
BOARD_VENDOR_RAMDISK_FRAGMENT.dlkm.KERNEL_MODULE_DIRS := top

BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    disable_dma32=on \
    mtdoops.fingerprint=$(LINEAGE_VERSION)
BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3

# Kernel modules
TARGET_COMPILE_WITH_MSM_KERNEL := false
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 0x020000 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x0C000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x01800000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06400000
BOARD_SUPER_PARTITION_SIZE := 9126805504 # 0x220000000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # 0x21FC00000 # BOARD_SUPER_PARTITION_SIZE - overhead (4MiB)

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

-include vendor/lineage/config/BoardConfigReservedSize.mk

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := taro

# Recovery
TARGET_RECOVERY_FSTAB := device/xiaomi/diting/rootdir/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

ifneq (,$(filter user, $(TARGET_BUILD_VARIANT)))
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/test
endif

# VINTF
DEVICE_MATRIX_FILE := hardware/qcom-caf/common/compatibility_matrix.xml

DEVICE_MANIFEST_SKUS += taro diwali cape ukee
$(foreach sku, $(call to-upper, $(DEVICE_MANIFEST_SKUS)), \
    $(eval DEVICE_MANIFEST_$(sku)_FILES := \
        $(COMMON_PATH)/vintf/vendor.dolby.media.c2.xml \
        $(COMMON_PATH)/vintf/vendor.dolby.hardware.dms@2.0-service.xml \
        $(COMMON_PATH)/vintf/manifest.xml \
        $(COMMON_PATH)/vintf/manifest_xiaomi.xml \
        $(if $(TARGET_NFC_SUPPORTED_SKUS),$(COMMON_PATH)/vintf/manifest_no_nfc.xml,) \
        hardware/qcom-caf/sm8450/audio/primary-hal/configs/common/manifest_non_qmaa.xml \
        hardware/qcom-caf/sm8450/audio/primary-hal/configs/common/manifest_non_qmaa_extn.xml \
    ))

ifneq ($(TARGET_NFC_SUPPORTED_SKUS),)
ODM_MANIFEST_SKUS += $(TARGET_NFC_SUPPORTED_SKUS)
$(foreach nfc_sku, $(call to-upper, $(TARGET_NFC_SUPPORTED_SKUS)), \
    $(eval ODM_MANIFEST_$(nfc_sku)_FILES += $(COMMON_PATH)/vintf/manifest_nfc.xml))
endif

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(COMMON_PATH)/vintf/dolby_framework_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    hardware/xiaomi/vintf/xiaomi_framework_compatibility_matrix.xml

DEVICE_FRAMEWORK_MANIFEST_FILE += $(COMMON_PATH)/vintf/framework_manifest.xml

# Verified Boot
ifeq ($(VENDOR_SECURITY_PATCH),)
$(error "VENDOR_SECURITY_PATCH must be set for vbmeta rollback index")
endif
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(shell date -d 'TZ="GMT" $(VENDOR_SECURITY_PATCH)' +%s)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

