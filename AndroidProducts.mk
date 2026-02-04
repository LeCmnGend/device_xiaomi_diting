#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_diting.mk

COMMON_LUNCH_CHOICES := \
    twrp_diting-user \
    twrp_diting-userdebug \
    twrp_diting-eng
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)/twrp
