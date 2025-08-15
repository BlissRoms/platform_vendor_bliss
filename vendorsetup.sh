#!/bin/bash -e

echo "- Generating vendor/bliss/prebuilt/generated/build-manifest.xml"
python3 .repo/repo/repo manifest -o - -r | grep -Ev "proprietary_${MANIFEST_EXCLUDES}" > vendor/bliss/prebuilt/generated/build-manifest.xml
