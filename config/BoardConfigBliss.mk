# Charger
ifneq ($(WITH_BLISS_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.bliss
endif
