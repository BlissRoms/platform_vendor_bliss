include vendor/bliss/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/bliss/config/BoardConfigQcom.mk
endif

include vendor/bliss/config/BoardConfigSoong.mk
