# Blobs from the vendor 3.10.72 ROM. Everything under proprietary/ is copied
# as is, so a blob that must not ship is deleted from the tree, not filtered.
# Modules Pie builds from source (libaudioflinger, libaudiopreprocessing,
# libOpenMAXAL, logwrapper, pppd, libbt-vendor, the sensors/lights/
# power HALs) and the telephony, FM, Widevine and face-unlock blobs are gone
# for that reason; see git history.

# bin
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/bin,system/bin)

# etc
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/etc,system/etc)

# lib
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/lib,system/lib)

# vendor
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/vendor,system/vendor)

# xbin
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/xbin,system/xbin)
