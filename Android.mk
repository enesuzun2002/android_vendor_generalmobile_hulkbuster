LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libdpframework
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/lib/libdpframework.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmtkplayer
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/lib/libmtkplayer.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
include $(BUILD_PREBUILT)

# WebView, taken from the vendor 3.10.72 ROM for this device.  The module is
# named "webview" on purpose so that the entry in
# build/target/product/core_minimal.mk resolves instead of being dropped.
#
# LOCAL_MODULE_PATH is $(TARGET_OUT_APPS) and not .../webview: base_rules.mk
# appends the module name for LOCAL_MODULE_CLASS := APPS ("Apk and its
# attachments reside in its own subdir"), so that yields the vendor layout
# /system/app/webview/webview.apk rather than a doubly nested directory.
#
# LOCAL_PREBUILT_JNI_LIBS is deliberately NOT set: the ~43 MB
# lib/armeabi-v7a/libwebviewchromium.so stays embedded in the APK, which is
# what LoadedApk.makePaths() expects for a bundled system app -- it adds
# "<apk>!/lib/<abi>" to the library search path.  Setting it would extract the
# library to $(dir $module)lib/arm, which does not match the bundled-app
# nativeLibraryDir of /system/lib/webview computed by
# PackageManagerService.setNativeLibraryPaths(), and would break the load.
#
# BUILD_PREBUILT (rather than PRODUCT_COPY_FILES) is required so that the
# prebuilt pipeline keeps lib/*.so stored uncompressed and re-runs zipalign
# after re-signing, without which the linker cannot mmap the library out of
# the archive.
include $(CLEAR_VARS)
LOCAL_MODULE := webview
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := $(DEFAULT_SYSTEM_DEV_CERTIFICATE)
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)
LOCAL_SRC_FILES := proprietary/app/webview/webview.apk
include $(BUILD_PREBUILT)
