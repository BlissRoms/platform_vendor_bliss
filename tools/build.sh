#!/bin/bash

#    BlissPop  Compilation Script
#
#    Copyright (C) 2015 Team Bliss
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


# No scrollback buffer
echo -e '\0033\0143'



# Get intial time of script startup
res1=$(date +%s.%N)



# Specify colors for shell
red='tput setaf 1'              # red
green='tput setaf 2'            # green
yellow='tput setaf 3'           # yellow
blue='tput setaf 4'             # blue
violet='tput setaf 5'           # violet
cyan='tput setaf 6'             # cyan
white='tput setaf 7'            # white
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold red
bldgrn=${txtbld}$(tput setaf 2) # Bold green
bldblu=${txtbld}$(tput setaf 4) # Bold blue
bldcya=${txtbld}$(tput setaf 6) # Bold cyan
normal='tput sgr0'


tput bold
tput setaf 1
clear
echo -e ""
echo -e "      ___           ___                   ___           ___              "
echo -e "     /\  \         /\__\      ___        /\  \         /\  \             "
echo -e "    /::\  \       /:/  /     /\  \      /::\  \       /::\  \            "
echo -e "   /:/\:\  \     /:/  /      \:\  \    /:/\ \  \     /:/\ \  \           "
echo -e "  /::\~\:\__\   /:/  /       /::\__\  _\:\~\ \  \   _\:\~\ \  \          "
echo -e " /:/\:\ \:|__| /:/__/     __/:/\/__/ /\ \:\ \ \__\ /\ \:\ \ \__\         "
echo -e " \:\~\:\/:/  / \:\  \    /\/:/  /    \:\ \:\ \/__/ \:\ \:\ \/__/         "
echo -e "  \:\ \::/  /   \:\  \   \::/__/      \:\ \:\__\    \:\ \:\__\           " 
echo -e "   \:\/:/  /     \:\  \   \:\__\       \:\/:/  /     \:\/:/  /           "  
echo -e "    \::/__/       \:\__\   \/__/        \::/  /       \::/  /            "
echo -e "     ~~            \/__/                 \/__/         \/__/             "
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""

sleep 3s


# Confirm 'repo sync'
echo -e "\n\n${bldgrn}  Do you want to repo sync before proceeding?\n"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askreposync

# Confirm 'make clean'
echo -e "\n\n${bldgrn}  Do you want to make clean?\n"
echo ""
echo -e "${bldblu}  1. Yes"
echo -e "${bldblu}  2. No"
echo ""
echo ""
$normal
read askClean

echo ""
echo ""
if [ "$askreposync" == "1" ]
then
    echo -e "${bldred}  Will repo sync before starting the build... "
else
    echo -e "${bldred}  Will continue without repo syncing... "
fi
echo ""
echo ""

echo ""
echo ""

if [ "$askClean" == "1" ]
then
    echo -e "${bldred}  Compilation will continue after cleaning previous build files... "
else
    echo -e "${bldred}  ROM will be compiled without cleaning previous build files... "
fi
echo ""
echo ""

echo ""
echo ""


sleep 2s


if [ "$askreposync" == "1" ]
then
	echo ""
	echo ""
	echo -e "${bldgrn}  syncing... "
	echo ""
	echo ""
	$normal
	repo sync -j250
fi

if [ "$askClean" == "1" ]
then
	echo ""
	echo ""
	echo -e "${bldgrn}  Cleaning before starting build... "
	echo ""
	echo ""
	$normal
	rm -rf out
fi

# Setup environment
echo -e ""
echo -e ""
echo -e "${bldgrn}  Setting up build environment..."
echo -e ""
echo -e ""
$normal
. build/envsetup.sh


# Lunch device
echo -e ""
echo -e ""
echo -e "${bldcya}  Choose your device from the lunch menu..."
echo -e ""
echo -e ""
$normal
$green
lunch

# Start compilation
echo -e ""
echo -e ""
echo -e "${bldcya}  Starting compilation BlissPop..."
echo -e ""
echo -e ""
$normal
mka bacon
echo -e ""



# Compilation complete
tput bold
tput setaf 1
echo -e ""
echo -e "The build process has finished"
echo -e ""
echo -e ""
