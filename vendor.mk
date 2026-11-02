# Blobs from the vendor 3.10.72 ROM that shadow modules Pie builds itself.
# The copies are N/M-era builds (e.g. libaudioflinger needs libaudioresampler,
# which Pie no longer has), so skip them and let the source-built ones install.
VENDOR_SHADOWED_LIBS := libaudioflinger libaudiopreprocessing libOpenMAXAL libcurl
VENDOR_SHADOWED_BINS := logwrapper pppd
# Legacy sensors HAL blobs (sensors.mt6592.so reports HAL 1.1, which Pie's
# sensors passthrough aborts on) and the closed MTK mag/orientation daemons:
# replaced by the native android.hardware.sensors@1.0-service.hulkbuster
# (device/generalmobile/hulkbuster/sensors). sensors.default.so is also built
# from source (hardware/libhardware stub).
# lights.mt6592 / power.default: replaced by the native light@2.0 / power@1.0
# services (device/generalmobile/hulkbuster/{lights,power}). power.default.so
# was the AOSP no-op stub; lights.mt6592.so probed RGB/jogball/keyboard LEDs
# that this device lacks.
VENDOR_SHADOWED_HW := sensors.mt6592 sensors.default lights.mt6592 power.default
VENDOR_SENSOR_DAEMONS := msensord orientationd geomagneticd akmd8975 akmd8963 akmd09911 bmm050d bmm056d
VENDOR_SHADOWED_COPY := \
    $(foreach l,$(VENDOR_SHADOWED_LIBS),$(VENDOR_PATH)/proprietary/lib/$(l).so:system/lib/$(l).so) \
    $(foreach b,$(VENDOR_SHADOWED_BINS),$(VENDOR_PATH)/proprietary/bin/$(b):system/bin/$(b)) \
    $(foreach h,$(VENDOR_SHADOWED_HW),$(VENDOR_PATH)/proprietary/lib/hw/$(h).so:system/lib/hw/$(h).so) \
    $(foreach b,$(VENDOR_SENSOR_DAEMONS),$(VENDOR_PATH)/proprietary/bin/$(b):system/bin/$(b))

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
