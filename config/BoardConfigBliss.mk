# Charger
ifeq ($(WITH_BLISS_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.bliss
endif
