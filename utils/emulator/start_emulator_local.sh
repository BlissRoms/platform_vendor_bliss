#!/bin/sh

# assumes the image zip has been extracted in /tmp

emulator  -verbose -skindir $ANDROID_BUILD_TOP/vendor/bliss/utils/emulator/skins/ -skin pixel_xl -writable-system
