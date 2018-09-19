# Charger
ifeq ($(WITH_BLISS_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.bliss
endif

# QCOM HW crypto
ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
    TARGET_CRYPTFS_HW_PATH ?= vendor/qcom/opensource/cryptfs_hw
endif

include vendor/bliss/config/BoardConfigKernel.mk
include vendor/lineage/config/BoardConfigSoong.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true) 
include vendor/bliss/config/BoardConfigQcom.mk 
endif 
