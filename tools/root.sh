#!/bin/bash
if [ -z "${DEFAULT_ROOT_METHOD}" ]; then
echo -e "\n\n Welcome to Bliss ROM, Please choose a ROOT METHOD!\n"
echo -e "";
echo -e " * 1 = Magisk Root "
echo -e "";
echo -e "";
echo -e " * 2 = SuperSU Root "
echo -e "";
echo -e "";
echo -e " * 3 = Rootless "
echo -e "";
echo -e "";
echo -e " **Please choose an option** "
echo -e "";
read askvariant
if [ "$askvariant" == "1" ];
then
echo -e "";
echo -e " Magisk Root Method "
export DEFAULT_ROOT_METHOD=magisk
echo -e "";
echo -e "";
else
if [ "$askvariant" == "2" ];
then
echo -e "";
echo -e " SuperSU Root Method"
export DEFAULT_ROOT_METHOD=supersu
echo -e "";
echo -e "";
else
if [ "$askvariant" == "3" ];
then
echo -e "";
echo -e " Rootless Build "
fi
fi
fi
fi
