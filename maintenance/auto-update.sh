#!/bin/bash

LOG_MAIN="/var/log/auto-update.log"
LOG_PKGS="/var/log/auto-update-packages.log"
DATE=$(date)

echo "[ $DATE ] Starting system update..." >> "$LOG_MAIN"
echo "==== $DATE ====" >> "$LOG_PKGS"

# Save current kernel
CURRENT_KERNEL=$(uname -r)

# Check what packages are going to be upgraded
apt list --upgradable 2>/dev/null | tail -n +2 >> "$LOG_PKGS"

# Run updates
apt update >> "$LOG_MAIN" 2>&1
apt -y upgrade >> "$LOG_MAIN" 2>&1
apt -y autoremove >> "$LOG_MAIN" 2>&1

# Check for kernel change
NEW_KERNEL=$(dpkg -l | grep linux-image | grep ^ii | awk '{print $2}' | sort -V | tail -n 1)

if ! uname -r | grep -q "$NEW_KERNEL"; then
    echo "[ $DATE ] Kernel was updated. Manual reboot recommended." | tee -a "$LOG_MAIN"
    echo "REBOOT REQUIRED (Kernel update): $NEW_KERNEL" >> "$LOG_PKGS"
else
    echo "[ $DATE ] No kernel update detected. No reboot needed." >> "$LOG_MAIN"
fi

echo -e "\n" >> "$LOG_PKGS"
