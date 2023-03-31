#!/usr/bin/sh
# COLORS
RED='\e[31m'     # Red
GREEN='\e[32m'   # Green
YELLOW='\e[33m'  # Yellow
ENDCOLOR='\e[0m' # Text Reset

# Clearing
tput sgr0 && clear

##Variables##
# OP Specific Repo
GIT_HOTDOGB="device_oneplus_hotdogb"
GIT_KERNEL="kernel_oneplus_sm8150"
GIT_VENDOR_COMMON="vendor_oneplus_sm8150-common"
GIT_VENDOR_HOTDOGB="vendor_oneplus_hotdogb"
GIT_HW="hardware_oneplus"

# QCOM
GIT_QCOM_COMMON="device_qcom_common"
GITLAB_QCOM_VENDOR="vendor_qcom_common"
GIT_QCOM_SEPOLICY="device_qcom_sepolicy_vndr"

# CLANG
CLANG="prebuilts_clang_host_linux-x86"

# GIT ORG
GIT_SILENT="git clone -q"
GIT_ANCIENT="https://github.com/Ancient-Roms"
GIT_KEVIOS12="https://www.github.com/kevios12"
GIT_YAAP="https://github.com/yaap"
GITLAB_YAAP="https://gitlab.com/yaosp"
GIT="git"

# BRANCHES GIT
DEPTH="--depth=1"
MASTER="master"
BRANCH1="thirteen"
BRANCH2="12.1"

# PATHES
OP_DEVICE_PATH="device/oneplus/hotdogb"
OP1_VENDOR_PATH="vendor/oneplus/sm8150-common"
OP2_VENDOR_PATH="vendor/oneplus/hotdogb"
QCOM_DEVICE_PATH="device/qcom/common"
QCOM_VENDOR_PATH="vendor/qcom/common"
KERNEL_PATH="kernel/oneplus/sm8150"
CLANG_PATH="prebuilts/clang/host/linux-x86"
QCOM_SEPOLICY_PATH="device/qcom/sepolicy_vndr"
##########################################
#VENDORSETUP BY KEVIOS12 V1.0 FOR HOTDOGB#
##########################################
while true; do
	read -p "Do u want start Cloning AncientOS Stuff for this Device? (Y/N):" answer
	tput sgr0 && clear
	# If yes, clone | if no, abort ...
	if [[ $answer == "y" || $answer == "Y" || $answer == "yes" || $answer = "Yes" ]]; then
		read -p "All already Cloned Files will be deleted. Do u want to continue? (Y/N):" confirmation
		tput sgr0 && clear
		if [[ $confirmation == "y" || $confirmation == "Y" || $confirmation == "yes" || $confirmation == "Yes" ]]; then
			echo ""
			# DeviceTree
			echo -e "-> Syncing Device Specific Trees ...${ENDCOLOR}"
			if [[ -d "$OP_DEVICE_PATH" ]]; then
			echo -e "${RED}-> $OP_DEVICE_PATH already exists, removing ...${ENDCOLOR}"
			rm -rf $OP_DEVICE_PATH
			fi
			echo -e "${YELLOW}-> Cloning ..."
			$GIT_SILENT $GIT_KEVIOS12/$GIT_HOTDOGB.$GIT -b ancient-13 $OP_DEVICE_PATH
			echo -e "${GREEN}-> DONE${ENDCOLOR}\n"

			# VENDOR
			echo -e "-> Syncing Device Specific Vendor ...${ENDCOLOR}"
			if [[ -d "$OP1_VENDOR_PATH" && -d "$OP2_VENDOR_PATH" ]]; then
			echo -e "${RED}-> Device Specific Vendor already exists, removing ..."
			rm -rf $OP1_VENDOR_PATH && rm -rf $OP2_VENDOR_PATH
			fi
			echo -e "${YELLOW}-> Cloning ..."
			$GIT_SILENT $GIT_YAAP/$GIT_VENDOR_COMMON.$GIT -b $BRANCH1 $OP1_VENDOR_PATH
			$GIT_SILENT $GIT_YAAP/$GIT_VENDOR_HOTDOGB.$GIT -b $BRANCH1 $OP2_VENDOR_PATH
			echo -e "${GREEN}-> DONE${ENDCOLOR}\n"

			# QCOM
			echo -e "-> Syncing QCOM Specific Repositories ...${ENDCOLOR}"
			if [[ -d "$QCOM_DEVICE_PATH" && -d "$QCOM_VENDOR_PATH" ]]; then
			echo -e "${RED}-> QCOM Specific Repositories already exists, removing ..."
			rm -rf $QCOM_VENDOR_PATH && rm -rf $QCOM_DEVICE_PATH
			fi
			echo -e "${YELLOW}-> Cloning ..."
			#fallback
			rm -rf $QCOM_DEVICE_PATH
			$GIT_SILENT $GIT_YAAP/$GIT_QCOM_COMMON.$GIT -b $BRANCH1 $QCOM_DEVICE_PATH
			$GIT_SILENT $GITLAB_YAAP/$GITLAB_QCOM_VENDOR.$GIT -b $BRANCH1 $QCOM_VENDOR_PATH
			echo -e "${GREEN}-> DONE${ENDCOLOR}\n"

			# Kernel
			echo -e "-> Syncing Gulch_r Kernel ...${ENDCOLOR}"
			if [[ -d "$KERNEL_PATH" ]]; then
			echo -e "${RED}-> Gulch_r Kernel already exists, removing ..."
			rm -rf $KERNEL_PATH
			fi
			echo -e "${YELLOW}-> Cloning ..."
			$GIT_SILENT $DEPTH $GIT_YAAP/$GIT_KERNEL.$GIT -b $BRANCH1 $KERNEL_PATH
			echo -e "${GREEN}-> DONE${ENDCOLOR}\n"

			# Clang-17 Prebuilts
			echo -e "-> Syncing YAAP Latest Clang Prebuilts [17] ...${ENDCOLOR}"
			echo -e "${YELLOW}-> Cloning ..."
			rm -rf $CLANG_PATH && $GIT_SILENT $DEPTH $GITLAB_YAAP/$CLANG.$GIT -b $MASTER $CLANG_PATH && echo -e "${GREEN}-> DONE${ENDCOLOR}\n"

			# Ancient-12 qcom-sepolicy-vndr
			echo -e "-> Using Ancient-12 SEPolicy ...${ENDCOLOR}"
			echo -e "${YELLOW}-> Cloning ..."
			rm -r $QCOM_SEPOLICY_PATH && $GIT_SILENT $GIT_ANCIENT/$GIT_QCOM_SEPOLICY -b $BRANCH2 $QCOM_SEPOLICY_PATH && echo -e "${GREEN}-> DONE${ENDCOLOR}\n"
			tput sgr0
			exit 0
		elif [[ $confirmation == "n" ]]; then
			echo -e "${RED}Aborted. Files won't be deleted${ENDCOLOR}"
			break
		else
			echo "Invalid Answer. Type 'y' for Yes or 'n' for No!"
		fi

	elif [[ $answer == "n" ]]; then
		echo -e "${RED}Aborted. Build manually.${ENDCOLOR}"
		break
	else
		echo "Invalid Answer. Type 'y' for Yes or 'n' for No!"
	fi
done
