#!/usr/bin/sh
# COLORS
GREEN="\e[32m"
RED="\e[31m"
ENDCOLOR="\e[0m"

# OP Specific Repo
GIT_HOTDOGB="device_oneplus_hotdogb"
GIT_KERNEL="kernel_oneplus_sm8150"
GIT_VENDOR_COMMON="vendor_oneplus_sm8150-common"
GIT_VENDOR_HOTDOGB="vendor_oneplus_hotdogb"
GIT_HW="hardware_oneplus"
# QCOM
GIT_QCOM_COMMON="device_qcom_common"
GITLAB_QCOM_VENDOR="vendor_qcom_common"
# CLANG
CLANG="prebuilts_clang_host_linux-x86"
# GIT ORG
GIT_KEVIOS12="https://www.github.com/kevios12/"
GIT_YAAP="https://github.com/yaap"
GITLAB_YAAP="https://gitlab.com/yaosp"
GIT="git"

DEPTH="--depth=1"
BRANCH="thirteen"

# Add YES/NO checks before nuking ......
echo -e "${GREEN}-> Syncing Device Specific Trees ...${ENDCOLOR}"
PATH1="device/oneplus/hotdogb"
if [[ -d "$PATH1" ]]; then
    rm -rf $PATH1
    git clone $GIT_KEVIOS12/$GIT_HOTDOGB.$GIT -b ancient-13 $PATH1
    echo -e "${RED}-> DONE${ENDCOLOR}"
else
    git clone $GIT_KEVIOS12/$GIT_HOTDOGB.$GIT -b ancient-13 $PATH1
    echo -e "${RED}-> DONE${ENDCOLOR}"
fi

echo -e "${GREEN}-> Syncing Device Specific Vendor ...${ENDCOLOR}"
PATH2="vendor/oneplus/sm8150-common"
PATH3="vendor/oneplus/hotdogb"
if [[ -d "$PATH2" && -d "$PATH3" ]]; then
    rm -rf $PATH2 && rm -rf $PATH3
    git clone $GIT_YAAP/$GIT_VENDOR_COMMON.$GIT -b $BRANCH $PATH2
    git clone $GIT_YAAP/$GIT_VENDOR_HOTDOGB.$GIT -b $BRANCH $PATH3
    echo -e "${RED}-> DONE${ENDCOLOR}"
else
    git clone $GIT_YAAP/$GIT_VENDOR_COMMON.$GIT -b $BRANCH $PATH2
    git clone $GIT_YAAP/$GIT_VENDOR_HOTDOGB.$GIT -b $BRANCH $PATH3
    echo -e "${RED}-> DONE${ENDCOLOR}"
fi

echo -e "${GREEN}-> Syncing QCOM Specific Repositories ...${ENDCOLOR}"
PATH4="device/qcom/common"
PATH5="vendor/qcom/common"
if [[ -d "$PATH4" && -d "$PATH5" ]]; then
    rm -rf $PATH4 && rm -rf $PATH5
    git clone $GIT_YAAP/$GIT_QCOM_COMMON.$GIT -b $BRANCH $PATH4
    git clone $GITLAB_YAAP/$GITLAB_QCOM_VENDOR.$GIT -b $BRANCH $PATH5
    echo -e "${RED}-> DONE${ENDCOLOR}"
else
    git clone $GIT_YAAP/$GIT_QCOM_COMMON.$GIT -b $BRANCH $PATH4
    git clone $GITLAB_YAAP/$GITLAB_QCOM_VENDOR.$GIT -b $BRANCH $PATH5
    echo -e "${RED}-> DONE${ENDCOLOR}"
fi

echo -e "${GREEN}-> Syncing Gulch_r Kernel ...${ENDCOLOR}"
PATH6="kernel/oneplus/sm8150"
if [[ -d "$PATH6" ]]; then
    rm -rf $PATH6
    git clone $DEPTH $GIT_YAAP/$GIT_KERNEL.$GIT -b $BRANCH $PATH6
    echo -e "${RED}-> DONE${ENDCOLOR}"
else
    git clone $DEPTH $GIT_YAAP/$GIT_KERNEL.$GIT -b $BRANCH $PATH6
    echo -e "${RED}-> DONE${ENDCOLOR}"
fi

echo -e "${GREEN}-> Syncing YAAP Latest Clang Prebuilts [17] ...${ENDCOLOR}"
CLANG_PATH="prebuilts/clang/host/linux-x86"
rm -rf $CLANG_PATH && git clone $DEPTH $GITLAB_YAAP/$CLANG.$GIT -b master $CLANG_PATH && echo -e "${RED}-> DONE${ENDCOLOR}"

echo -e "${GREEN}-> Using Ancient-12 SEPolicy ...${ENDCOLOR}"
QCOM_SEPOLICY="device/qcom/sepolicy_vndr"
rm -r $QCOM_SEPOLICY && git clone https://github.com/Ancient-Roms/device_qcom_sepolicy_vndr -b 12.1 $QCOM_SEPOLICY && echo -e "${RED}-> DONE${ENDCOLOR}"
