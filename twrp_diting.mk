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

PRODUCT_MODEL := 22081212UG

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="diting_global-user 15 AQ3A.241006.001 OS2.0.206.0.VLFMIXM release-keys" \
    BuildFingerprint=Xiaomi/diting_global/diting:15/AQ3A.241006.001/OS2.0.206.0.VLFMIXM:user/release-keys \
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
