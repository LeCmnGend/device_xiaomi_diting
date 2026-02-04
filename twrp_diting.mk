# OrangeFox / TWRP recovery product for diting

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device.
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit any OrangeFox-specific settings
$(call inherit-product-if-exists, $(LOCAL_PATH)/fox_diting.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_DEVICE := diting
PRODUCT_NAME := twrp_diting
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := diting
PRODUCT_MANUFACTURER := Xiaomi

$(call inherit-product, device/xiaomi/diting/device.mk)

VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
#VENDOR_SECURITY_PATCH := 2025-11-01

# OFOX: block Xiaomi diting (IMS / WFD / system_ext)
PRODUCT_PACKAGES_REMOVE += \
    libimsmedia_jni \
    libimscamera_jni \
    libimsrtp_jni \
    libwfdservice \
    libwfdsinksm \
    libwfdrtsp \
    libwfdcommonutils
