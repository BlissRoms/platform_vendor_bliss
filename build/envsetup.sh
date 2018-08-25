# bliss functions that extend build/envsetup.sh
function __print_bliss_functions_help() {
cat <<EOF
Additional BlissRoms functions:
- breakfast:       Setup the build environment, but only list
                   devices we support.
- brunch:          Sets up build environment using breakfast(),
                   and then comiles using mka() against blissify target.
- mka:             Builds using SCHED_BATCH on all processors.
- pushboot:        Push a file from your OUT dir to your phone and
                   reboots it, using absolute path.
EOF
}

function bliss_device_combos()
{
    local T list_file variant device

    T="$(gettop)"
    list_file="${T}/vendor/bliss/bliss.devices"
    variant="userdebug"

    if [[ $1 ]]
    then
        if [[ $2 ]]
        then
            list_file="$1"
            variant="$2"
        else
            if [[ ${VARIANT_CHOICES[@]} =~ (^| )$1($| ) ]]
            then
                variant="$1"
            else
                list_file="$1"
            fi
        fi
    fi

    if [[ ! -f "${list_file}" ]]
    then
        echo "unable to find device list: ${list_file}"
        list_file="${T}/vendor/bliss/bliss.devices"
        echo "defaulting device list file to: ${list_file}"
    fi

    while IFS= read -r device
    do
        add_lunch_combo "bliss_${device}-${variant}"
    done < "${list_file}"
}

function bliss_rename_function()
{
    eval "original_bliss_$(declare -f ${1})"
}

function _bliss_build_hmm() #hidden
{
    printf "%-8s %s" "${1}:" "${2}"
}

function bliss_append_hmm()
{
    HMM_DESCRIPTIVE=("${HMM_DESCRIPTIVE[@]}" "$(_bliss_build_hmm "$1" "$2")")
}

function bliss_add_hmm_entry()
{
    for c in ${!HMM_DESCRIPTIVE[*]}
    do
        if [[ "${1}" == $(echo "${HMM_DESCRIPTIVE[$c]}" | cut -f1 -d":") ]]
        then
            HMM_DESCRIPTIVE[${c}]="$(_bliss_build_hmm "$1" "$2")"
            return
        fi
    done
    bliss_append_hmm "$1" "$2"
}

function blissremote()
{
    local proj pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm bliss 2> /dev/null

    proj="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"

    if (echo "$proj" | egrep -q 'external|system|build|bionic|art|libcore|prebuilt|dalvik') ; then
        pfx="platform_"
    fi

    project="${proj//\//_}"

    git remote add bliss "git@github.com:BlissRoms/$pfx$project"
    echo "Remote 'bliss' created"
}

function losremote()
{
    local proj pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm cm 2> /dev/null

    proj="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    pfx="android_"
    project="${proj//\//_}"
    git remote add los "git@github.com:LineageOS/$pfx$project"
    echo "Remote 'los' created"
}

function aospremote()
{
    local pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm aosp 2> /dev/null

    project="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    if [[ "$project" != device* ]]
    then
        pfx="platform/"
    fi
    git remote add aosp "https://android.googlesource.com/$pfx$project"
    echo "Remote 'aosp' created"
}

function cafremote()
{
    local pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
    fi
    git remote rm caf 2> /dev/null

    project="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    if [[ "$project" != device* ]]
    then
        pfx="platform/"
    fi
    git remote add caf "git://codeaurora.org/$pfx$project"
    echo "Remote 'caf' created"
}

function bliss_push()
{
    local branch ssh_name path_opt proj
    branch="o8.1"
    ssh_name="bliss_review"
    path_opt=

    if [[ "$1" ]]
    then
        proj="$ANDROID_BUILD_TOP/$(echo "$1" | sed "s#$ANDROID_BUILD_TOP/##g")"
        path_opt="--git-dir=$(printf "%q/.git" "${proj}")"
    else
        proj="$(pwd -P)"
    fi
    proj="$(echo "$proj" | sed "s#$ANDROID_BUILD_TOP/##g")"
    proj="$(echo "$proj" | sed 's#/$##')"
    proj="${proj//\//_}"

    if (echo "$proj" | egrep -q 'external|system|build|bionic|art|libcore|prebuilt|dalvik') ; then
        proj="platform_$proj"
    fi

    git $path_opt push "ssh://${ssh_name}/BlissRoms/$proj" "HEAD:refs/for/$branch"
}


bliss_rename_function hmm
function hmm() #hidden
{
    local i T
    T="$(gettop)"
    original_bliss_hmm
    echo

    echo "vendor/bliss extended functions. The complete list is:"
    for i in $(grep -P '^function .*$' "$T/vendor/bliss/build/envsetup.sh" | grep -v "#hidden" | sed 's/function \([a-z_]*\).*/\1/' | sort | uniq); do
        echo "$i"
    done |column
}

function mk_timer()
{
    local start_time=$(date +"%s")
    $@
    local ret=$?
    local end_time=$(date +"%s")
    local tdiff=$(($end_time-$start_time))
    local hours=$(($tdiff / 3600 ))
    local mins=$((($tdiff % 3600) / 60))
    local secs=$(($tdiff % 60))
    local ncolors=$(tput colors 2>/dev/null)
    echo
    if [ $ret -eq 0 ] ; then
        echo -n "#### make completed successfully "
    else
        echo -n "#### make failed to build some targets "
    fi
    if [ $hours -gt 0 ] ; then
        printf "(%02g:%02g:%02g (hh:mm:ss))" $hours $mins $secs
    elif [ $mins -gt 0 ] ; then
        printf "(%02g:%02g (mm:ss))" $mins $secs
    elif [ $secs -gt 0 ] ; then
        printf "(%s seconds)" $secs
    fi
    echo " ####"
    echo
    return $ret
}

function brunch()
{
    breakfast $*
    if [ $? -eq 0 ]; then
        time mka blissify
    else
        echo "No such item in brunch menu. Try 'breakfast'"
        return 1
    fi
    return $?
}

function breakfast()
{
    target=$1
    local variant=$2
    BLISS_DEVICES_ONLY="true"
    unset LUNCH_MENU_CHOICES
    add_lunch_combo full-eng
    for f in `/bin/ls device/*/*/vendorsetup.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
    unset f

    if [ $# -eq 0 ]; then
        # No arguments, so let's have the full menu
        lunch
    else
        echo "z$target" | grep -q "-"
        if [ $? -eq 0 ]; then
            # A buildtype was specified, assume a full device name
            lunch $target
        else
            # This is probably just the bliss model name
            if [ -z "$variant" ]; then
                variant="userdebug"
            fi
            lunch bliss_$target-$variant
        fi
    fi
    return $?
}

alias bib=breakfast

function repopick() {
    T=$(gettop)
    $T/vendor/bliss/build/tools/repopick.py $@
}

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    if [ ! -z $ANDROID_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

# Make using all available CPUs
function mka() {
    m -j "$@"
}

function pushboot() {
    if [ ! -f $OUT/$* ]; then
        echo "File not found: $OUT/$*"
        return 1
    fi

    adb root
    sleep 1
    adb wait-for-device
    adb remount

    adb push $OUT/$* /$*
    adb reboot
}

# Enable SD-LLVM if available
if [ -d $(gettop)/prebuilts/snapdragon-llvm/toolchains ]; then
    case `uname -s` in
        Darwin)
            # Darwin is not supported yet
            ;;
        *)
            export SDCLANG=true
            export SDCLANG_PATH=$(gettop)/prebuilts/snapdragon-llvm/toolchains/llvm-Snapdragon_LLVM_for_Android_4.0/prebuilt/linux-x86_64/bin
            export SDCLANG_PATH_2=$(gettop)/prebuilts/snapdragon-llvm/toolchains/llvm-Snapdragon_LLVM_for_Android_4.0/prebuilt/linux-x86_64/bin
            export SDCLANG_LTO_DEFS=$(gettop)/vendor/lineage/build/core/sdllvm-lto-defs.mk
            ;;
    esac
fi
