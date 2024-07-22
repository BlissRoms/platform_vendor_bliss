LOCAL_PATH := $(call my-dir)

################################
# Copies the APN list file into $(TARGET_COPY_OUT_PRODUCT)/etc for the product as apns-conf.xml.
include $(CLEAR_VARS)

LOCAL_MODULE := apns-conf.xml
LOCAL_MODULE_CLASS := ETC

LOCAL_PREBUILT_MODULE_FILE := vendor/bliss/prebuilt/common/etc/apns-conf.xml

LOCAL_PRODUCT_MODULE := true

include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := WeatherIcons
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := WeatherIcons/$(LOCAL_MODULE).apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)
