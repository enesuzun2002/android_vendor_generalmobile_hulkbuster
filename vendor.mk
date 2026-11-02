# Blobs from the vendor 3.10.72 ROM that shadow modules Pie builds itself.
# The copies are N/M-era builds (e.g. libaudioflinger needs libaudioresampler,
# which Pie no longer has), so skip them and let the source-built ones install.
VENDOR_SHADOWED_LIBS := libaudioflinger libaudiopreprocessing libOpenMAXAL libcurl
VENDOR_SHADOWED_BINS := logwrapper pppd
VENDOR_SHADOWED_COPY := \
    $(foreach l,$(VENDOR_SHADOWED_LIBS),$(VENDOR_PATH)/proprietary/lib/$(l).so:system/lib/$(l).so) \
    $(foreach b,$(VENDOR_SHADOWED_BINS),$(VENDOR_PATH)/proprietary/bin/$(b):system/bin/$(b))

# bin
PRODUCT_COPY_FILES += $(filter-out $(VENDOR_SHADOWED_COPY),$(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/bin,system/bin))

# etc
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/etc,system/etc)

# lib
PRODUCT_COPY_FILES += $(filter-out $(VENDOR_SHADOWED_COPY),$(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/lib,system/lib))

# vendor
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/vendor,system/vendor)

# xbin
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(VENDOR_PATH)/proprietary/xbin,system/xbin)
