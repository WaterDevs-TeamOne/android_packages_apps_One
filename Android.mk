LOCAL_PATH:= $(call my-dir)

# We have a special case here where we build the library's resources
# independently from its code, so we need to find where the resource
# class source got placed in the course of building the resources.
# Thus, the magic here.
# Also, this module cannot depend directly on the R.java file; if it
# did, the PRIVATE_* vars for R.java wouldn't be guaranteed to be correct.
# Instead, it depends on the R.stamp file, which lists the corresponding
# R.java file as a prerequisite.
one_platform_res := APPS/com.teamone.one.platform-res_intermediates/src

# List of packages used in lineage-api-stubs
one_stub_packages := one.app:one.content:one.hardware:one.media:one.os:one.preference:one.profiles:one.providers:one.platform:one.power:one.util:one.weather:one.weatherservice:one.style

# The OneOS Platform Framework Library
# ============================================================

include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := OneParts
LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_STATIC_ANDROID_LIBRARIES := \
    androidx.appcompat_appcompat \
    androidx.dynamicanimation_dynamicanimation \
    androidx.legacy_legacy-support-v13 \
    androidx.palette_palette \
    androidx.preference_preference \
    androidx.recyclerview_recyclerview

LOCAL_STATIC_JAVA_LIBRARIES := \
    jsr305 \
    com.teamone.platform.internal

LOCAL_RESOURCE_DIR := \
    $(LOCAL_PATH)/res

LOCAL_USE_AAPT2 := true

LOCAL_PRIVATE_PLATFORM_APIS := true

LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_PROGUARD_FLAG_FILES := proguard.flags

ifneq ($(INCREMENTAL_BUILDS),)
    LOCAL_PROGUARD_ENABLED := disabled
    LOCAL_JACK_ENABLED := incremental
    LOCAL_DX_FLAGS := --multi-dex
    LOCAL_JACK_FLAGS := --multi-dex native
endif

include frameworks/base/packages/SettingsLib/common.mk

include $(BUILD_PACKAGE)
