# OrangeFox / TWRP recovery product for diting

# Inherit from device.
$(call inherit-product, device/xiaomi/diting/device.mk)

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
PRODUCT_MODEL := 22081212UG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="diting_global-user 16 AQ3A.241006.001 OS2.0.206.0.VLFMIXM release-keys" \
    BuildFingerprint=Xiaomi/diting_global/diting:16/AQ3A.241006.001/OS2.0.206.0.VLFMIXM:user/release-keys \
    DeviceProduct=diting \
    SystemName=diting_global

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
#VENDOR_SECURITY_PATCH := 2025-11-01

# OFOX: block Xiaomi diting (IMS / WFD / system_ext)
#PRODUCT_PACKAGES_REMOVE += \
#    libimsmedia_jni \
#    libimscamera_jni \
#    libimsrtp_jni \
#    libwfdservice \
#    libwfdsinksm \
#    libwfdrtsp \
#    libwfdcommonutils

# Real A/B, NOT Virtual A/B
TARGET_USES_VIRTUAL_AB := false
# A/B
ENABLE_AB := true
ENABLE_VIRTUAL_AB := false
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

# Building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Encryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)