add_json_str_omitempty = $(if $(strip $(2)),$(call add_json_str, $(1), $(2)))
add_json_val_default = $(call add_json_val, $(1), $(if $(strip $(2)), $(2), $(3)))

_contents := $(_contents)    "Bliss":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_str, Java_Source_Overlays, $(JAVA_SOURCE_OVERLAYS))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
