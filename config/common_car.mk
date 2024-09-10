# Inherit common Bliss stuff
$(call inherit-product, vendor/bliss/config/common.mk)

# Inherit Bliss car device tree
$(call inherit-product, device/bliss/car/bliss_car.mk)

# Inherit the main AOSP car makefile that turns this into an Automotive build
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
